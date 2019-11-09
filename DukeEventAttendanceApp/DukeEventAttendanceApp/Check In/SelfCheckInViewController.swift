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

class SelfCheckInViewController: UIViewController, CLLocationManagerDelegate { 
   
    var event:Event = Event(id: "", start_date: "", end_date: "", summary: "", description: "", status: "", sponsor: "", co_sponsors: "", location: ["":""], contact: ["":""], categories: [""], link: "", event_url: "", series_name: "", image_url: "")!
    var attendees_array:[String] = []
    var circlecolor = ""
    var desiredLoc = CLLocation()
    
    
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
    var helper = SelfCheckInHelperMethods()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
        locationManager.distanceFilter = 100
        
        let location:String = ""
        let coords:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 35.995817, longitude: -78.942043)
        geoFenceRegion = CLCircularRegion(center: coords, radius: 100, identifier: location)
        isInBounds = geoFenceRegion.contains(myLocation.coordinate)
        
        locationManager.startMonitoring(for: geoFenceRegion)
        //loadAllGeotifications()
    }
    
    @IBAction func checkInTapped(_ sender: Any) {
        print("in bounds: ")
        print(self.isInBounds)
        if( self.isInBounds ){
            var hnc = self.storyboard?.instantiateViewController(withIdentifier: "mainNav") as? UINavigationController
            if (hnc == nil) {
                hnc = self.storyboard?.instantiateViewController(withIdentifier: "hostNav") as? UINavigationController
            }
            var alert = helper.loadAttendee(nav: hnc!, event_id: event.id) as! UIAlertController
            self.present(alert, animated:true)
            circlecolor = "green"
        } else {
            var alert = UIAlertController(title: "Invalid", message: "You are not within the designated self check-in location", preferredStyle: .alert)
            alert.addAction( UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            circlecolor = "red"
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
        self.drawCircle(location: desiredLoc, color: circlecolor)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        for currentLocation in locations{
            myLocation = currentLocation
            isInBounds = geoFenceRegion.contains(myLocation.coordinate)
            map.setRegion(MKCoordinateRegion(center: myLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)), animated: true)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("entered")
        self.isInBounds = true
        print(region.identifier)
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("exited")
        self.isInBounds = false 
        print(region.identifier)
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
    
}
