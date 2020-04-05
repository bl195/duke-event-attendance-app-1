//
//  QRCodeViewController.swift
//  DukeEventAttendanceApp
//
//  Created by Brian Li on 7/2/19.
//  Copyright © 2019 Duke OIT. All rights reserved.
//
import UIKit

/*
 This class is responsible for showing a QR code icon that,
 when pressed, will allow the user(host) to navigate to the
 screen that has the actual functionality of scanning an attendee's
 bar code/QR code.
 */
class QRCodeViewController: UIViewController {

    var event_id = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    /*
     Overiding the prepare function to create a segue to the QRScannerController,
     which provides the functionality of allowing a host to scan an attendee's
     bar code or QR code. 
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showScan") {
            let scanVC = segue.destination as? QRScannerController
            scanVC?.event_id = event_id
        }
        
    }
    
    
    
}
