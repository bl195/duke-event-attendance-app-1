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

class SelfCheckInViewController: UIViewController{
    
    var event:Event = Event(id: "", start_date: "", end_date: "", summary: "", description: "", status: "", sponsor: "", co_sponsors: "", location: ["":""], contact: ["":""], categories: [""], link: "", event_url: "", series_name: "", image_url: "")!
    var attendees_array:[String] = []
    var circlecolor = ""
    
    
    @IBOutlet weak var blueBackground: UIImageView!
    
    @IBOutlet weak var whiteBackground: UIImageView!
    @IBOutlet weak var eventTitle: UILabel!
    
    
    @IBOutlet weak var eventTime: UILabel!
    
    @IBOutlet weak var eventLocationLabel: UILabel!
    
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var map: MKMapView!
    
    let manager = CLLocationManager()
    
    var myLat = CLLocationDegrees()
    var myLong = CLLocationDegrees()
    var myLocation = CLLocation()
    var eventLocation = ""
    var isInBounds = false
    var eventid = ""
    
    override func viewDidLoad() {
        self.navigationController?.isNavigationBarHidden = false
        super.viewDidLoad()
        
        
        self.map.delegate = self
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestAlwaysAuthorization()
        manager.requestLocation()
        manager.startUpdatingLocation()
        manager.stopUpdatingLocation()
        
        
        eventTitle.text = event.summary
        print ("something")
        print (event.summary)
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
        //confirmButton.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        //confirmButton.clipsToBounds = true
        
        checkLocation(eventlocation: self.eventLocation + ", Durham")
        
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
        var hnc = self.storyboard?.instantiateViewController(withIdentifier: "mainNav") as? UINavigationController
        if (hnc == nil) {
            hnc = self.storyboard?.instantiateViewController(withIdentifier: "hostNav") as? UINavigationController
        }
        loadAttendee(nav: hnc!, event_id: event.id)
    }
    
    func loadAttendee (nav: UINavigationController, event_id: String) {
        //indicator.startAnimating()
        print (event_id)
        let createAttendeeMutation = SelfCheckInMutation(eventid: event_id)
        Apollo().getClient().perform(mutation: createAttendeeMutation) { [unowned self] result, error in
            if let error = error as? GraphQLHTTPResponseError {
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
                print("success")
                print(result?.data?.selfCheckIn?.id ?? "no attendee")
                let alert = UIAlertController(title: "You have successfully checked in", message: "", preferredStyle: .alert)
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
                //guard for TWO KINDS OF ERRORS: 1) not valid student and 2) already checked in
                self.invalidityCheck()
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
                //guard for TWO KINDS OF ERRORS: 1) not valid student and 2) already checked in
                self.invalidityCheck()
            }

        }
    }
    
    func invalidityCheck(){
        var alertMessage = ""
        let query = AllAttendeesQuery(id: self.eventid)
        Apollo().getClient().fetch(query: query, cachePolicy: .fetchIgnoringCacheData) { [unowned self] results, error in
            if let attendees = results?.data?.allAttendees{
                for attendee in attendees {
                    var att = attendee.resultMap["duid"]!! as! String
                    if( att == Items.sharedInstance.my_dukecardnumber ) { //needs to be changed
                        alertMessage = "You have already checked in"
                    } else {
                        alertMessage = "Your card number is invalid or the host has not opened the event for check-in"
                    }
                }
            }
            let alert = UIAlertController(title: "Your check-in cannot be validated", message: alertMessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    func checkLocation(eventlocation:String) {
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
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            for item in response.mapItems {
                print("mapitems ")
                print(item)
                desiredLoc = item.placemark.location!
                desiredCoords = item.placemark.coordinate
                print(item.placemark.coordinate ?? "No phone number." )
                var distance = self.myLocation.distance(from: desiredLoc)
                if( distance <= 100){
                    self.isInBounds = true
                    self.drawCircle(location: desiredLoc, color: "green")
                }
            }
            //self.isInBounds = true
            if ( !self.isInBounds ){
                var alert = UIAlertController(title: "Invalid", message: "You are not within the designated self check-in location", preferredStyle: .alert)
                alert.addAction( UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
                self.blueBackground.isHidden = true
                self.whiteBackground.isHidden = true
                self.eventLocationLabel.isHidden = true
                self.eventTime.isHidden = true
                self.confirmButton.isHidden = true
                self.eventTitle.isHidden = true
                
                let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                let region: MKCoordinateRegion = MKCoordinateRegion(center: desiredLoc.coordinate, span: span)
                self.map.setRegion(region, animated: true)
                self.map.showsUserLocation = true
                self.drawCircle(location: desiredLoc, color: "red")
            }
            
            let region = CLCircularRegion(center: desiredLoc.coordinate,
                                          radius: 100,
                                          identifier: self.event.summary)
            // 2
            region.notifyOnExit = true
            startMonitoring(region:region)
        }
        
        func startMonitoring(region:CLCircularRegion) {
            // 1
            if !CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
                //showAlert(withTitle:"Error", message: "Geofencing is not supported on this device!")
                return
            }
            // 2
            if CLLocationManager.authorizationStatus() != .authorizedAlways {
                let message = """
      Your geotification is saved but will only be activated once you grant
      Geotify permission to access the device location.
      """
               // showAlert(withTitle:"Warning", message: message)
            }
            let fenceRegion = region
            manager.startMonitoring(for: fenceRegion)
        }
        
        func stopMonitoring() {
            for region in manager.monitoredRegions {
                guard let circularRegion = region as? CLCircularRegion,
                    circularRegion.identifier == self.event.summary else { continue }
                manager.stopMonitoring(for: circularRegion)
            }
        }


        
    }
    
}

extension SelfCheckInViewController : MKMapViewDelegate{
    func drawCircle(location:CLLocation, color:String) {
        var circle = MKCircle(center: location.coordinate, radius: 100 as CLLocationDistance)
        circlecolor = color
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
            print("my location: ")
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
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
     
        if region is CLCircularRegion {
            let currentDateTime = Date()
            let formatter = DateFormatter()
            formatter.timeStyle = .medium
            formatter.dateStyle = .none
            let curr_time = formatter.string(from: currentDateTime)
            self.checkOutAttendee(nav: self.navigationController!, event_id: event.id, time: curr_time)
            print("LEFTLEFTLEFT")
        }
    }
    
}
