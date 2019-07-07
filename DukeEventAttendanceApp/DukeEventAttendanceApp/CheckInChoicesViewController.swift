//
//  CheckInChoicesViewController.swift
//  DukeEventAttendanceApp
//
//  Created by Jessica Su on 7/2/19.
//  Copyright © 2019 Duke OIT. All rights reserved.
//

import UIKit

class CheckInChoicesViewController: UIViewController {

    var event:Event = Event(id: "", start_date: "", end_date: "", summary: "", description: "", status: "", sponsor: "", co_sponsors: "", location: ["":""], contact: ["":""], categories: [""], link: "", event_url: "", series_name: "", image_url: "")!
    //var eventName:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print ("event summary:" + event.summary)
        //print ("event name:" + eventName)

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toSelfCheck") {
            let sVC = segue.destination as? SelfCheckInViewController
            sVC?.event = event
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
