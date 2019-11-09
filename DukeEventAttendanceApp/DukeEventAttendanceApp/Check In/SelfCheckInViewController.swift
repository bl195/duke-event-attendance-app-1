//
//  SelfCheckInViewController.swift
//  DukeEventAttendanceApp
//
//  Created by Jessica Su and Luiza Wolf on 6/26/19.
//  Copyright © 2019 Duke OIT. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

import Apollo

class SelfCheckInViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var blueBackground: UIImageView!
    
    @IBOutlet weak var whiteBackground: UIImageView!
    @IBOutlet weak var eventTitle: UILabel!
    
    
    @IBOutlet weak var eventTime: UILabel!
    
    @IBOutlet weak var eventLocationLabel: UILabel!
    
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var map: MKMapView!
    
    let locationManager = CLLocationManager()
    var myLocation = CLLocation()
    var eventLocation = ""
    var isInBounds = false
    var eventid = ""
    var geoFenceRegion:CLCircularRegion = CLCircularRegion()
    var event:Event = Event(id: "", start_date: "", end_date: "", summary: "", description: "", status: "", sponsor: "", co_sponsors: "", location: ["":""], contact: ["":""], categories: [""], link: "", event_url: "", series_name: "", image_url: "")!
    var attendees_array:[String] = []
    var circlecolor = ""
    var desiredLoc = CLLocation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.map.delegate = self
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
        locationManager.distanceFilter = 100
        
        let location:String = ""
        getLocation(eventlocation: self.eventLocation)
        
        eventTitle.text = event.summary
        eventTitle.numberOfLines = 5
        
        eventTime.text = "TIME: " + event.starttime + "-" + event.endtime
        eventLocationLabel.text = "LOCATION: " + event.address
        
        blueBackground.layer.cornerRadius = 10.0
        blueBackground.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        blueBackground.clipsToBounds = true
        
        whiteBackground.layer.cornerRadius = 10.0
        whiteBackground.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        whiteBackground.clipsToBounds = true
        confirmButton.layer.cornerRadius = 30.0

    }
    
    @IBAction func checkInTapped(_ sender: Any) {
        print("in bounds: ")
        print(self.isInBounds)
        if( self.isInBounds ){
            var hnc = self.storyboard?.instantiateViewController(withIdentifier: "mainNav") as? UINavigationController
            if (hnc == nil) {
                hnc = self.storyboard?.instantiateViewController(withIdentifier: "hostNav") as? UINavigationController
            }
            loadAttendee(nav: hnc!, event_id: event.id)
            //circlecolor = "green"
        } else {
            var alert = UIAlertController(title: "Invalid", message: "You are not within the designated self check-in location", preferredStyle: .alert)
            alert.addAction( UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            //circlecolor = "red"
        }
        self.blueBackground.isHidden = true
        self.whiteBackground.isHidden = true
        self.eventLocationLabel.isHidden = true
        self.eventTime.isHidden = true
        self.confirmButton.isHidden = true
        self.eventTitle.isHidden = true
        let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        //let region: MKCoordinateRegion = MKCoordinateRegion(center: desiredLoc.coordinate, span: span)
        //self.map.setRegion(region, animated: true)
        self.map.showsUserLocation = true
    }
    
    func invalidityCheck(event_id:String){
        var alertMessage = ""
        var alert = UIAlertController()
        let query = AllAttendeesQuery(id: event_id)
//        Apollo().getClient().fetch(query: query, cachePolicy: .fetchIgnoringCacheData) { [unowned self] results, error in
//            if let attendees = results?.data?.allAttendees{
//                for attendee in attendees {
//                    var att = attendee.resultMap["duid"]!! as! String
//                    if( att == Items.sharedInstance.my_dukecardnumber ) { //needs to be changed
//                        alertMessage = "You have already checked in"
//                    } else {
//                        alertMessage = "Your card number is invalid or the host has not opened the event for check-in"
//                    }
//                }
//            }
//            alert = UIAlertController(title: "Your check-in cannot be validated", message: alertMessage, preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
//            self.present(alert, animated: true)
//        }
        alert = UIAlertController(title: "Your check-in cannot be validated", message: alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        for currentLocation in locations{
            myLocation = currentLocation
            //isInBounds = geoFenceRegion.contains(myLocation.coordinate)
            map.setRegion(MKCoordinateRegion(center: myLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)), animated: true)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("entered")
        self.isInBounds = true
        print(region.identifier)
    }
    
    func loadAttendee (nav: UINavigationController, event_id: String){
        //indicator.startAnimating()
        print (event_id)
        let createAttendeeMutation = SelfCheckInMutation(eventid: event_id)
        var alert = UIAlertController()
        Apollo().getClient().perform(mutation: createAttendeeMutation) { [unowned self] result, error in
            if let error = error as? GraphQLHTTPResponseError  {
                switch (error.response.statusCode) {
                case 401:
                    //request unauthorized due to bad token
                    
                    OAuthService.shared.refreshToken(navController: nav) { success, statusCode in
                        if success {
                            self.loadAttendee(nav: nav, event_id: event_id)
                        } else {
                            //handle error
                        }
                        
                    }
                default:
                    print ("error")
                }
            }
            else if (result?.data?.selfCheckIn?.id != nil) {
                print(result?.data?.selfCheckIn?.id ?? "no attendee")
                self.checkedinalready = true
                let alert = UIAlertController(title: "You have successfully checked in", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                self.present(alert, animated:true)
                //self.present(alert, animated: true)
                //return alert
                //                self.blueBackground.isHidden = true
                //                self.whiteBackground.isHidden = true
                //                self.eventLocationLabel.isHidden = true
                //                self.eventTime.isHidden = true
                //                self.confirmButton.isHidden = true
                //                self.eventTitle.isHidden = true
            }
            else {
                self.invalidityCheck(event_id: event_id)
            }
            
        }
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("exited")
        self.isInBounds = false 
        print(region.identifier)
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateStyle = .none
        let curr_time = formatter.string(from: currentDateTime)
        self.checkOutAttendee(nav: self.navigationController!, event_id: self.eventid, time: curr_time)
    }
    
    func drawCircle(location:CLLocation, color:String) {
        var circle = MKCircle(center: location.coordinate, radius: 100 as CLLocationDistance)
        self.circlecolor = color
        self.map.addOverlay(circle)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKCircle {
            var circle = MKCircleRenderer(overlay: overlay)
            if( circlecolor == "green"){
                circle.strokeColor = UIColor.green
                circle.fillColor = UIColor(red: 0, green: 255, blue: 0, alpha: 0.1)
            }
            if( circlecolor == "red"){
                circle.strokeColor = UIColor.red
                circle.fillColor = UIColor(red: 255, green: 0, blue: 0, alpha: 0.1)
            }
            circle.lineWidth = 1
            return circle
        }
        return MKOverlayRenderer()
    }
    
    func getLocation(eventlocation:String){
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = eventlocation
        var desiredLoc = CLLocation()
        var desiredCoords = CLLocationCoordinate2D()
        let search = MKLocalSearch(request: searchRequest)
        
        search.start { response, error in
            guard let response = response else {
                print("Error: \(error?.localizedDescription ?? "Unknown error").")
                var alert = UIAlertController(title: "Event location not found.", message: "Please alert the event host.", preferredStyle: .alert)
                alert.addAction( UIAlertAction(title: "OK", style: .cancel, handler: nil))
                //self.present(alert, animated: true, completion: nil)
                return
            }
            for item in response.mapItems {
                print("mapitems ")
                print(item)
                desiredLoc = item.placemark.location!
                var coords = desiredLoc.coordinate
                self.geoFenceRegion = CLCircularRegion(center: coords, radius: 100, identifier: eventlocation)
                self.isInBounds = self.geoFenceRegion.contains(self.myLocation.coordinate)
                
                self.locationManager.startMonitoring(for: self.geoFenceRegion)
                self.map.setRegion(MKCoordinateRegion(center: desiredLoc.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)), animated: true)
                if( self.isInBounds ) {
                    self.drawCircle(location: desiredLoc, color: "green")
                } else {
                    self.drawCircle(location: desiredLoc, color: "red")
                }
            }
        }
    }
    
    func checkOutAttendee(nav: UINavigationController, event_id: String, time: String) {
        print("checking out attendee mutation")
        let checkOutMutation = CheckOutMutation(eventid: event_id, time: time)
        Apollo().getClient().perform(mutation: checkOutMutation) { [unowned self] result, error in
            if let error = error as? GraphQLHTTPResponseError {
                switch (error.response.statusCode) {
                case 401:
                    //request unauthorized due to bad token
                    
                    OAuthService.shared.refreshToken(navController: nav) { success, statusCode in
                        if success {
                            self.checkOutAttendee(nav: nav, event_id: event_id, time: time)
                        } else {
                            //handle error
                        }
                        
                    }
                default:
                    print ("error")
                }
            }
            else if (result?.data?.checkOut?.id != nil) {
                print("success")
                print(result?.data?.checkOut?.id ?? "no attendee")
                let alert = UIAlertController(title: "Thank you for attending.", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                self.present(alert, animated: true)
                self.blueBackground.isHidden = true
                self.whiteBackground.isHidden = true
                self.eventLocationLabel.isHidden = true
                self.eventTime.isHidden = true
                self.confirmButton.isHidden = true
                self.eventTitle.isHidden = true
                
            }
            else {
            }
            
        }
    }
    
}
