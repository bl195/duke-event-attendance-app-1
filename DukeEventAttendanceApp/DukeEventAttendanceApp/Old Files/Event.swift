//
//  Event.swift
//  PracticeJSONCalendar
//
//  Created by Luiza Wolf on 6/5/19.
//  Copyright © 2019 Luiza Wolf. All rights reserved.
//

import UIKit

class Event{
    var id : String
    var start_time: String
    var end_time: String
    var summary: String
    var description: String
    var status: String
    var sponsor: String
    var co_sponsors: String
    var location: Dictionary<String, String>
    var contact: Dictionary<String, String>
    var categories: [String]
    var link: String
    var event_url: String
    var series_name: String
    var image_url: String
    
    var contact_name: String = ""
    var contact_email: String = ""
    var address: String = ""
    var maps_link: String = ""
    

    
    init?(id: String, start_time: String, end_time: String, summary: String, description: String, status: String, sponsor: String, co_sponsors: String, location: Dictionary<String, String>, contact: Dictionary<String, String>, categories: [String], link: String, event_url: String, series_name: String, image_url: String) {

        
        self.id = id
        self.start_time = start_time
        self.end_time = end_time
        self.summary = summary
        self.description = description
        self.status = status
        self.sponsor = sponsor
        self.co_sponsors = co_sponsors
        self.location = location
        self.contact = contact
        self.categories = categories
        self.link = link
        self.event_url = event_url
        self.series_name = series_name
        self.image_url = image_url
        self.location = location
        
        self.contact_name = contact["name"] ?? ""
        self.contact_email = contact["email"] ?? ""
        self.address = location["address"] ?? ""
        self.maps_link = location["link"] ?? ""
        
    }
    
    
}

