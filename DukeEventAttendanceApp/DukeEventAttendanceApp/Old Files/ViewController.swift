//
//  ViewController.swift
//  PracticeJSONCalendar
//
//  Created by Luiza Wolf on 5/31/19.
//  Copyright © 2019 Luiza Wolf. All rights reserved.
//

import UIKit


class ViewController: UIViewController {


    @IBOutlet weak var futureDaysField: UITextField!
    @IBOutlet weak var event0title: UILabel!
    
   
    
    @IBAction func searchEvents(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let input = futureDaysField.text
        
        /**var eventArray = [Event]()
        
        NetworkManager.downloadCalendarInfo { jsonData in
            
            if let events = jsonData["events"] as? Array<Dictionary<String,Any>>{
                
                for event in events{
                    
                    var date_beg:String = "bla"
                    if let start_time = event["start_timestamp"] as? String{
                        let formatterInput = ISO8601DateFormatter()
                        if let date = formatterInput.date(from: start_time){
                            let formatterOutput = DateFormatter()
                            formatterOutput.locale = Locale(identifier: "en_US")
                            formatterOutput.dateStyle = .short
                            formatterOutput.timeStyle = .short
                            date_beg = formatterOutput.string(from: date)
                        }
                    }
                    
                    var date_end:String = "bla 2"
                    if let start_time = event["end_timestamp"] as? String{
                        let formatterInput = ISO8601DateFormatter()
                        if let date = formatterInput.date(from: start_time){
                            let formatterOutput = DateFormatter()
                            formatterOutput.locale = Locale(identifier: "en_US")
                            formatterOutput.dateStyle = .short
                            formatterOutput.timeStyle = .short
                            date_end = formatterOutput.string(from: date)
                        }
                    }
                    
                    
                    guard let event0 = Event(id: event["id"] as? String ?? "",
                                             start_time: date_beg,
                                             end_time: date_end,
                                             summary: event["summary"] as? String ?? "",
                                             description: event["description"] as? String ?? "",
                                             status: event["status"] as? String ?? "",
                                             sponsor: event["sponsor"] as? String ?? "",
                                             co_sponsors: event["co_sponsors"] as? String ?? "",
                                             location: event["location"] as! Dictionary<String,String>,
                                             contact: event["contact"] as! Dictionary<String,String>,
                                             categories: event["categories"] as! [String],
                                             link: event["link"] as? String ?? "",
                                             event_url: event["event_url"] as? String ?? "",
                                             series_name: event["series_name"] as? String ?? "",
                                             image_url: event["image_url"] as? String ?? "")
                        else{
                        fatalError("Unable to instantiate event")
                        }
                    
                    eventArray.append( event0 )
                            
                    }
                }
        }**/
        
    }


}

