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

class SelfCheckInViewController: UIViewController, CLLocationManagerDelegate {

    
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
    
    func checkLocation() {
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        // Do any additional setup after loading the view.
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
