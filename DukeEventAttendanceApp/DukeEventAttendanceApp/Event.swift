//
//  Event.swift
//  DukeEventAttendanceApp
//
//  Created by Luiza Wolf on 6/6/19.
//  Copyright © 2019 Duke OIT. All rights reserved.
//

import UIKit

/**
    Constructor for Event class
 **/
class Event: Equatable{
    static func == (lhs: Event, rhs: Event) -> Bool {
        if lhs.id == rhs.id {
            return true
        }
        return false
    }
    
    var id : String
    var summary: String         //event's title
    var description: String
    var status: String          //if event has been confirmed or not
    var sponsor: String
    var co_sponsors: String
    var location: Dictionary<String, String>    //dictionary from JSON data, contains Google maps link and                                               address
    var contact: Dictionary<String, String>     //dictionary from JSON data, can contain contact name, email,                                            and phone number
    var categories: [String]                    //categories that the event is classified under
    var link: String                            //link to event on Duke calendar
    var event_url: String                       //external link to event
    var series_name: String                     //if the event is part of a series, then the name of the series
    var image_url: String
    
    var start_date: String      //raw JSON date, indicated by "start_timestamp" e.g "2019-01-19T15:00:00Z"
    var end_date: String        //raw JSON date, indicated by "end_timestamp" e.g "2019-01-19T15:00:00Z"
    var startmonth: String      //parsed JSON, start month
    var startday: String        //parsed JSON, start day
    var endmonth: String
    var endday: String
    var starttime: String       //parsed JSON, start time
    var endtime: String         //parsed JSON, end time
    var longmonth: String
    
    var contact_name: String
    var contact_email: String
    var address: String
    var maps_link: String
    
    var ongoing: Bool
    var sorted_date: Date

    
    init?(id: String, start_date: String, end_date: String, summary: String, description: String, status: String, sponsor: String, co_sponsors: String, location: Dictionary<String, String>, contact: Dictionary<String, String>, categories: [String], link: String, event_url: String, series_name: String, image_url: String) {
        
        //assigning private variables from parameters
        self.id = id
        self.start_date = start_date
        self.end_date = end_date
        self.summary = summary
        self.description = description.replacingOccurrences(of: "0x0A", with: "\n")
        self.status = status
        self.sponsor = sponsor
        self.co_sponsors = co_sponsors
        self.location = location
        self.contact = contact
        self.categories = categories
        self.link = link
        self.event_url = event_url
        self.series_name = series_name
        self.location = location
        //self.ongoing = ongoing
        
        //initialize image URL, assigning random default image if there is none passed in the parameters
        if( image_url != ""){
            self.image_url = image_url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        }
        else{
            self.image_url = getRandomImageURL()
        }
        
        //inititalize empty fields
        self.contact_name = ""
        self.contact_email = ""
        self.address = ""
        self.maps_link = ""
        self.startmonth = ""
        self.longmonth = ""
        self.startday = ""
        self.endmonth = ""
        self.endday = ""
        self.starttime = ""
        self.endtime = ""
        self.ongoing = false
         self.sorted_date = Date()
        
        
        //call method to initialize startmonth, startday, starttime, and endtime
        simpTimeStamp(starttimestamp: start_date, endtimestamp: end_date, sorteddate: sorted_date)
        
        //intitialize with information from dictionaries
        self.contact_name = contact["name"] ?? ""
        self.contact_email = contact["email"] ?? ""
        self.address = location["address"] ?? ""
        self.maps_link = location["link"] ?? ""
        
    }
    
    
    /**
        Mutator method to assign formatted values to start_date, startmonth, startday, starttime, endtime
     **/
    func simpTimeStamp(starttimestamp: String, endtimestamp: String, sorteddate: Date){
        let formatterInput = ISO8601DateFormatter()
        if let date = formatterInput.date(from: starttimestamp){
            let formatterOutput = DateFormatter()
            formatterOutput.dateFormat = "MMM d, yyyy"
            formatterOutput.locale = Locale(identifier: "en_US")
            //formatterOutput.dateStyle = .short
            //formatterOutput.timeStyle = .short
            start_date = formatterOutput.string(from: date)
            sorted_date = formatterOutput.date(from: start_date) ?? Date()
            formatterOutput.dateFormat = "MMM"
            startmonth = formatterOutput.string(from: date)
            formatterOutput.dateFormat = "MMMM"
            longmonth = formatterOutput.string(from: date)
            formatterOutput.dateFormat = "d"
            startday = formatterOutput.string(from: date)
            formatterOutput.dateFormat = "h:mm a"
            starttime = formatterOutput.string(from: date)
        }
        
        if let date = formatterInput.date(from: endtimestamp){
            let formatterOutput = DateFormatter()
            formatterOutput.dateFormat = "MMM d, yyyy"
            formatterOutput.locale = Locale(identifier: "en_US")
            end_date = formatterOutput.string(from: date)
            formatterOutput.dateFormat = "MMM"
            endmonth = formatterOutput.string(from: date)
            formatterOutput.dateFormat = "d"
            endday = formatterOutput.string(from: date)
            formatterOutput.dateFormat = "h:mm a"
            endtime = formatterOutput.string(from: date)
        }
        
    }
    
    func makeOngoing(){
        self.ongoing = true
    }
    
    
    
}

func getRandomImageURL() -> String{
    let imageURLs:[String] = ["https://calendar.duke.edu/assets/v2016/featured-event-4.png",
                              "https://calendar.duke.edu/assets/v2016/featured-event-3.png",
                              "https://calendar.duke.edu/assets/v2016/featured-event-4.png",
                              "https://calendar.duke.edu/assets/v2016/featured-event-5.png"]
    let randomNumber = Int.random(in: 0...3)
    return imageURLs[randomNumber]
}


