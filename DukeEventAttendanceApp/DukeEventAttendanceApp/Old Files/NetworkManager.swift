//
//  NetworkManager.swift
//  PracticeJSONCalendar
//
//  Created by Luiza Wolf on 6/4/19.
//  Copyright © 2019 Luiza Wolf. All rights reserved.
//

import Foundation


var day_range = "10"
var filter = "" //&gfu[]=Career%20Center"
var spec_url = "https://calendar.duke.edu/events/index.json?" + filter + "&future_days=" + day_range + "&feed_type=simple"

class NetworkManager{
    static func downloadCalendarInfo(completion:@escaping ([String: Any]) -> () ){
        
        
        let url = URL(string: spec_url)
        let task = URLSession.shared.dataTask(with: url!){ data, response, error in //respoonse is HTTP response, data is data
            
            if let error = error{
                return
            }
            
            do{
                if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any]{
                    //Serialize = convert the data into JSON
                    DispatchQueue.main.async{
                        completion(json)
                    }
                }
                
                
            } catch {
                print( "JSON error: \(error.localizedDescription)")
            }
            //catches if the try fails
            //Any is any data type
            //higher-order function takes another function as a parameter
        }
        task.resume()
    }
}

//class CalendarEvent(summary, date)
