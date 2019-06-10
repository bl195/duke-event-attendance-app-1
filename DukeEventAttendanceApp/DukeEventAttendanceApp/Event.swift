//
//  Event.swift
//  DukeEventAttendanceApp
//
//  Created by Luiza Wolf on 6/6/19.
//  Copyright © 2019 Duke OIT. All rights reserved.
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
    //var image:UIImage
    
    var startmonth: String
    var startday: String
    
    var contact_name: String = ""
    var contact_email: String = ""
    var address: String = ""
    var maps_link: String = ""
    
    
    
    init?(id: String, start_time: String, end_time: String, summary: String, description: String, status: String, sponsor: String, co_sponsors: String, location: Dictionary<String, String>, contact: Dictionary<String, String>, categories: [String], link: String, event_url: String, series_name: String, image_url: String,
          start_month: String, start_day: String) {
        
        
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
        
        if( image_url != ""){
            self.image_url = image_url
        }
        else{
            self.image_url = getRandomImageURL()
        }
        
        
        
        self.location = location
        
        self.startmonth = start_month
        self.startday = start_day
        
        self.contact_name = contact["name"] ?? ""
        self.contact_email = contact["email"] ?? ""
        self.address = location["address"] ?? ""
        self.maps_link = location["link"] ?? ""
        
    }
    
//    func getImage() -> UIImage{
//        let url = self.image_url
////        return imageFromUrl(imageUrl: url)
//    }
    
//    func imageFromUrl(imageUrl:String) -> UIImage{
//        var image:UIImage = UIImage()
//        if let imageUrl = URL(string: imageUrl) {
//            // This is a network call and needs to be run on non-UI thread
//            DispatchQueue.global().async {
//                let imageData = try! Data(contentsOf: imageUrl)
//                image = UIImage(data: imageData)!
//            }
//        }
//       return image
//    }
//
}

func getRandomImageURL() -> String{
    let imageURLs:[String] = ["https://calendar.duke.edu/assets/v2016/featured-event-4.png",
                              "https://calendar.duke.edu/assets/v2016/featured-event-3.png",
                              "https://calendar.duke.edu/assets/v2016/featured-event-4.png",
                              "https://calendar.duke.edu/assets/v2016/featured-event-5.png"]
    let randomNumber = Int.random(in: 0...3)
    return imageURLs[randomNumber]
}

