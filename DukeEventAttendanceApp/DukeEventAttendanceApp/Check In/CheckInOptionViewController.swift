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
        
        //self.navigationController?.isNavigationBarHidden = true
        // Do any additional setup after loading the view.
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
