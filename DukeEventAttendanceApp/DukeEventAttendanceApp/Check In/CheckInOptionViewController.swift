//
//  CheckInOptionViewController.swift
//  DukeEventAttendanceApp
//
//  Created by Luiza Wolf on 7/6/19.
//  Copyright © 2019 Duke OIT. All rights reserved.
//

import UIKit

class CheckInOptionViewController: UIViewController {
    
    @IBOutlet weak var QRButton: UIButton!
    @IBOutlet weak var SelfCheckInButton: UIButton!
    var eventLoc = ""
    var eventID = ""
    var event:Event = Event(id: "", start_date: "", end_date: "", summary: "", description: "", status: "", sponsor: "", co_sponsors: "", location: ["":""], contact: ["":""], categories: [""], link: "", event_url: "", series_name: "", image_url: "")!

    override func viewDidLoad() {
        self.navigationController?.isNavigationBarHidden = false
        super.viewDidLoad()
        print(eventID)
        
        SelfCheckInButton.layer.cornerRadius = 20.0
        QRButton.layer.cornerRadius = 20.0
        print (event.id)
        Items.sharedInstance.eventActiveandCheckIn(eventid: event.id, nav: self.navigationController!){ active, checkInType, error in
            if( active ){
                if (checkInType == "qr") {
                    self.SelfCheckInButton.isEnabled = false
                    self.SelfCheckInButton.setTitle("Self Check-in Not Available", for: .disabled)
                    self.SelfCheckInButton.titleLabel?.attributedText = NSAttributedString(string: "Self Check-in Not Available", attributes: [NSAttributedString.Key.font: UIFont(name: "Helvetica-Light", size: 14)!])
                    self.SelfCheckInButton.backgroundColor = UIColor.gray }
                else if (checkInType == "self"){
                    self.QRButton.isEnabled = false
                    self.QRButton.setTitle("QR Check-in Not Available", for: .disabled)
                    self.QRButton.titleLabel?.attributedText = NSAttributedString(string: "QR Check-in Not Available", attributes: [NSAttributedString.Key.font: UIFont(name: "Helvetica-Light", size: 14)!])
                    self.QRButton.backgroundColor = UIColor.gray }
                    
            } else {
                let alert = UIAlertController(title: "Invalid Operation", message: "The host has not opened the event for check in yet", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {(action) -> Void in
                    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MyAgendaViewController") as? MyAgendaViewController
                    self.navigationController?.pushViewController(vc!, animated: true)
                } ) )
                
                self.present(alert, animated: true, completion: nil)
            }
        }
            
        
        Items.sharedInstance.eventActive(eventid: event.id, nav: self.navigationController!){ active, error in
            if( active ){
                Items.sharedInstance.checkInType(eventid: self.event.id, nav: self.navigationController!){ type, error in
                    if( type == "qr" ){
                        self.SelfCheckInButton.isEnabled = false
                        self.SelfCheckInButton.setTitle("Self Check-in Not Available", for: .disabled)
                        self.SelfCheckInButton.titleLabel?.attributedText = NSAttributedString(string: "Self Check-in Not Available", attributes: [NSAttributedString.Key.font: UIFont(name: "Helvetica-Light", size: 14)!])
                        self.SelfCheckInButton.backgroundColor = UIColor.gray
                    } else if( type == "self"){
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
    
    @IBAction func QRCodeButton(_ sender: Any) {
        let qvc = self.storyboard?.instantiateViewController(withIdentifier: "QRCheckInViewController") as? QRCheckInViewController
        qvc?.event = self.event
        self.navigationController?.pushViewController(qvc!, animated: true)
        
    }
    
    @IBAction func selfCheckInButton(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SelfCheckInViewController") as? SelfCheckInViewController
        vc?.eventLocation = eventLoc
        vc?.eventid = eventID
        vc?.event = self.event
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toQRCheck") {
            let qvc = self.storyboard?.instantiateViewController(withIdentifier: "QRCheckInViewController") as? QRCheckInViewController
            qvc?.event = self.event
            
        }
        
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
