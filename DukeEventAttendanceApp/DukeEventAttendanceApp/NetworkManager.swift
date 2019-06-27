//
//  NetworkManager.swift
//  DukeEventAttendanceApp
//
//  Created by Luiza Wolf on 6/6/19.
//  Copyright © 2019 Duke OIT. All rights reserved.
//

import Foundation


class NetworkManager{
    static func downloadCalendarInfo(specific_url: String, completion:@escaping ([String: Any]) -> () ){
        
        //print (specific_url)
        let url = URL(string: specific_url)
       
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
