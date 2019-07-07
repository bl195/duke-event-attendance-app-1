//
//  CheckInOptionViewController.swift
//  DukeEventAttendanceApp
//
//  Created by Luiza Wolf on 7/6/19.
//  Copyright © 2019 Duke OIT. All rights reserved.
//

import UIKit

class CheckInOptionViewController: UIViewController {
    
    var eventLoc = ""
    var eventID = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func QRCodeButton(_ sender: Any) {
    }
    
    @IBAction func selfCheckInButton(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SelfCheckInViewController") as? SelfCheckInViewController
        vc?.eventLocation = eventLoc
        vc?.eventid = eventID
        self.navigationController?.pushViewController(vc!, animated: true)
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
