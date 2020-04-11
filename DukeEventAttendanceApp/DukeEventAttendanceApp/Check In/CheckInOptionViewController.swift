//
//  CheckInOptionViewController.swift
//  DukeEventAttendanceApp
//
//  Created by Jessica Su on 7/6/19.
//  Copyright © 2019 Duke OIT. All rights reserved.
//

import UIKit
import CoreLocation

/*
    This class is responsible for displaying the check-in options for a
    particular event for the user. Currently, these options are self check-in and QR code
    check-in. Depending on the check-in type the host chooses, the attendee will be presented
    with a blue, enabled button for the designated check-in type and a disabled, greyed-out
    button for the other type.
*/
class CheckInOptionViewController: UIViewController {
    
    @IBOutlet weak var QRButton: UIButton!
    @IBOutlet weak var SelfCheckInButton: UIButton!
    var eventLoc = ""
    var eventID = ""
    var usingHostLoc = false
    var event:Event = Event(id: "", start_date: "", end_date: "", summary: "", description: "", status: "", sponsor: "", co_sponsors: "", location: ["":""], contact: ["":""], categories: [""], link: "", event_url: "", series_name: "", image_url: "")!
    var hostLocLat = ""
    var hostLocLong = ""
    var graphQLManager = GraphQLManager()

    override func viewDidLoad() {
        self.navigationController?.isNavigationBarHidden = false
        super.viewDidLoad()
        SelfCheckInButton.layer.cornerRadius = 20.0
        QRButton.layer.cornerRadius = 20.0
        
        //based on the nature of the event, modifies the check-in option for the attendee.
        graphQLManager.eventActive(eventid: event.id, nav: self.navigationController!){ active, error in
            if( active ){
                self.graphQLManager.checkInType(eventid: self.event.id, nav: self.navigationController!){ type, hostlat, hostlong, error in
                    if( type == "qr" ){
                        self.SelfCheckInButton.isEnabled = false
                        self.SelfCheckInButton.setTitle("Self Check-in Not Available", for: .disabled)
                        self.SelfCheckInButton.titleLabel?.attributedText = NSAttributedString(string: "Self Check-in Not Available", attributes: [NSAttributedString.Key.font: UIFont(name: "Helvetica-Light", size: 14)!])
                        self.SelfCheckInButton.backgroundColor = UIColor.gray
                    } else {
                        if (type == "self_host_loc") {
                            self.usingHostLoc = true
                            //update HostLocLat and HostLocLong depending on query
                            self.hostLocLat = hostlat
                            self.hostLocLong = hostlong
                        }
                        
                        self.QRButton.isEnabled = false
                        self.QRButton.setTitle("QR Check-in Not Available", for: .disabled)
                        self.QRButton.titleLabel?.attributedText = NSAttributedString(string: "QR Check-in Not Available", attributes: [NSAttributedString.Key.font: UIFont(name: "Helvetica-Light", size: 14)!])
                        self.QRButton.backgroundColor = UIColor.gray
                    }
                }
            } else {
                let alert = UIAlertController(title: "Invalid Operation", message: "The host has not opened the event for check in yet", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {(action) -> Void in
                    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MyAgendaViewController") as? MyAgendaViewController
                    self.navigationController?.pushViewController(vc!, animated: true)
                } ) )

                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    /*
        If the QR code check-in button is selected, goes to screen that displays
        the attendee's QR code.
    */
    @IBAction func QRCodeButton(_ sender: Any) {
        let qvc = self.storyboard?.instantiateViewController(withIdentifier: "QRCheckInViewController") as? QRCheckInViewController
        qvc?.event = self.event
        self.navigationController?.pushViewController(qvc!, animated: true)
        
    }
    /*
         If the self check-in button is selected, goes to screen that enables self check-in.
    */
    @IBAction func selfCheckInButton(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SelfCheckInViewController") as? SelfCheckInViewController
        vc?.eventLocation = eventLoc
        vc?.eventid = eventID
        vc?.event = self.event
        vc?.usingHostLoc = self.usingHostLoc
        vc?.hostLocLat = self.hostLocLat
        vc?.hostLocLong = self.hostLocLong
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    /*
        Sends the event information to the screen displaying the QR code.
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toQRCheck") {
            let qvc = self.storyboard?.instantiateViewController(withIdentifier: "QRCheckInViewController") as? QRCheckInViewController
            qvc?.event = self.event
        }
    }
    
}
