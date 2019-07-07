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

class SelfCheckInViewController: UIViewController {

    
    @IBOutlet weak var map: MKMapView!
    
    let locationManager = CLLocationManager()
    
    var myLat = CLLocationDegrees()
    var myLong = CLLocationDegrees()
    var myLocation = CLLocation()
    var eventLocation = ""
    var isInBounds = false
    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let location = locations[0]
//        let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
//        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
//        let region: MKCoordinateRegion = MKCoordinateRegion(center: myLocation, span: span)
//        map.setRegion(region, animated: true)
//
//        self.map.showsUserLocation = true
//        myLat = location.coordinate.latitude
//        myLong = location.coordinate.longitude
//    }
//
//    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
//        print("error:: (error)")
//    }
//
//    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
//        if status == .authorizedWhenInUse {
//            manager.requestLocation()
//        }
//    }
    
    func checkLocation(eventlocation:String, userlocation:CLLocation) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = eventlocation
        var desiredLoc = CLLocation()
        var desiredCoords = CLLocationCoordinate2D()
        let search = MKLocalSearch(request: searchRequest)
        
        search.start { response, error in
            guard let response = response else {
                print("Error: \(error?.localizedDescription ?? "Unknown error").")
                return
            }
            
            for item in response.mapItems {
                print(item)
                desiredLoc = item.placemark.location!
                self.drawCircle(location: desiredLoc)
                desiredCoords = item.placemark.coordinate
                print(item.placemark.coordinate ?? "No phone number.")
                var distance = self.myLocation.distance(from: desiredLoc)
                if( distance <= 100){
                    self.isInBounds = true
                }
            }
            var alert = UIAlertController()
            if( self.isInBounds ){
                alert = UIAlertController(title: "Would you like to check in?", message: "You are within a designated self check-in location", preferredStyle: .alert)
                alert.addAction( UIAlertAction(title: "Check In", style: .default, handler: nil))
                alert.addAction( UIAlertAction(title: "Cancel", style: .cancel, handler: nil) )
                //self.present(alert, animated: true, completion: nil)
            } else {
                alert = UIAlertController(title: "Invalid", message: "You are not within the designated self check-in location", preferredStyle: .alert)
                alert.addAction( UIAlertAction(title: "OK", style: .cancel, handler: nil))
                //self.present(alert, animated: true, completion: nil)
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        
    }
    
    
    override func viewDidLoad() {
        
        self.map.delegate = self;
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        //locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.stopUpdatingLocation()
        checkLocation(eventlocation: self.eventLocation + ", Durham", userlocation: myLocation)

        
        super.viewDidLoad()
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SelfCheckInViewController : MKMapViewDelegate{
    func drawCircle(location:CLLocation) {
        var circle = MKCircle(center: location.coordinate, radius: 100 as CLLocationDistance)
        self.map.addOverlay(circle)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKCircle {
            var circle = MKCircleRenderer(overlay: overlay)
            circle.strokeColor = UIColor.green
            circle.fillColor = UIColor(red: 0, green: 255, blue: 0, alpha: 0.1)
            circle.lineWidth = 1
            return circle
        }
        return MKOverlayRenderer()
    }
//    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
//        if( ){
//            let circleView = MKCircleRenderer(overlay: <#T##MKOverlay#>)
//            return circleView }
//
//        return MKOverlayRenderer()
//    }
}

extension SelfCheckInViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            manager.requestLocation()
        }
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    // do stuff
                }
            }
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print(location)
            let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
            let region: MKCoordinateRegion = MKCoordinateRegion(center: myLocation, span: span)
            map.setRegion(region, animated: true)
            self.map.showsUserLocation = true
            self.myLocation = location
        }
//        map.setRegion(region: MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius, regionRadius), animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: (error)")
    }
    
}
