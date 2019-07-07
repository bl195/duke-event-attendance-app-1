//
//  SelfCheckInViewController.swift
//  DukeEventAttendanceApp
//
//  Created by Jessica Su on 6/26/19.
//  Copyright © 2019 Duke OIT. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

import Apollo

class SelfCheckInViewController: UIViewController, CLLocationManagerDelegate {

    var event:Event = Event(id: "", start_date: "", end_date: "", summary: "", description: "", status: "", sponsor: "", co_sponsors: "", location: ["":""], contact: ["":""], categories: [""], link: "", event_url: "", series_name: "", image_url: "")!
    var attendees_array:[String] = []
    

    @IBOutlet weak var blueBackground: UIImageView!
    
    @IBOutlet weak var whiteBackground: UIImageView!
    @IBOutlet weak var eventTitle: UILabel!
    
    
    @IBOutlet weak var eventTime: UILabel!
    
    @IBOutlet weak var eventLocation: UILabel!
    
    
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var map: MKMapView!
    
    let manager = CLLocationManager()
    
    var myLat = CLLocationDegrees()
    var myLong = CLLocationDegrees()
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region: MKCoordinateRegion = MKCoordinateRegion(center: myLocation, span: span)
        map.setRegion(region, animated: true)
        
        self.map.showsUserLocation = true
        myLat = location.coordinate.latitude
        myLong = location.coordinate.longitude
    }
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        eventTitle.text = event.summary
        print ("something")
        print (event.summary)
        eventTitle.numberOfLines = 5
        
        eventTime.text = "TIME: " + event.starttime + "-" + event.endtime
        eventLocation.text = "LOCATION: " + event.address
        
        blueBackground.layer.cornerRadius = 10.0
        blueBackground.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        blueBackground.clipsToBounds = true
        
        whiteBackground.layer.cornerRadius = 10.0
        whiteBackground.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        whiteBackground.clipsToBounds = true
        confirmButton.layer.cornerRadius = 20
        //confirmButton.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        //confirmButton.clipsToBounds = true
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    @IBAction func confirmCheckIn(_ sender: Any) {
        //queryAllAttendees()
        //print (attendees_array)
        loadAttendee(event_id: event.summary)
    }
    
    //let apollo = ApolloClient(url: URL(string: "http://localhost:3000/graphql")!)
    func loadAttendee (event_id: String) {
        //indicator.startAnimating()
        let createAttendeeMutation = CheckInAttendeeMutation (eventid: event_id, duid: "6033006990241122")
        Apollo.shared.client.perform(mutation: createAttendeeMutation) { [unowned self] result, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if (result?.data?.attendeeCheckIn?.id != nil) {
                print("success")
                print(result?.data?.attendeeCheckIn?.id ?? "no attendee")
                let alert = UIAlertController(title: "You have successfully checked in", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                self.present(alert, animated: true)
                
            }
            else {
                //guard for TWO KINDS OF ERRORS: 1) not valid student and 2) already checked in
                print ("not valid check in")
                let alert = UIAlertController(title: "Your check-in cannot be validated", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                self.present(alert, animated: true)
                
            }
            
        }
    
    }
    func queryAllAttendees() {
        let allAttendeesQuery = AllAttendeesQuery (id: "burger event")
        Apollo.shared.client.fetch(query: allAttendeesQuery, cachePolicy: .fetchIgnoringCacheData) { [unowned self] result, error in
            if let attendees  = result?.data?.allAttendees {
                for attendee in attendees {
                    self.attendees_array.append(attendee.resultMap["duid"]!! as! String)
                    self.reloadInputViews()
                }
            }
            
        }
    }
    
}
