//
//  Event+CoreDataProperties.swift
//  DukeEventAttendanceApp
//
//  Created by Luiza Wolf on 6/19/19.
//  Copyright © 2019 Duke OIT. All rights reserved.
//
//

import Foundation
import CoreData


extension Event {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Event> {
        return NSFetchRequest<Event>(entityName: "Event")
    }

    @NSManaged public var address: String?
    @NSManaged public var co_sponsors: String?
    @NSManaged public var contact_email: String?
    @NSManaged public var contact_name: String?
    @NSManaged public var desc: String?
    @NSManaged public var duke_cal_link: String?
    @NSManaged public var end_date: String?
    @NSManaged public var end_time: String?
    @NSManaged public var ext_event_link: String?
    @NSManaged public var id: String?
    @NSManaged public var image_url: String?
    @NSManaged public var maps_link: String?
    @NSManaged public var series_name: String?
    @NSManaged public var sponsor: String?
    @NSManaged public var start_date: String?
    @NSManaged public var start_day: String?
    @NSManaged public var start_month: String?
    @NSManaged public var start_time: String?
    @NSManaged public var status: String?
    @NSManaged public var summary: String?
    
    func getRandomImageURL() -> String{
        let imageURLs:[String] = ["https://calendar.duke.edu/assets/v2016/featured-event-4.png",
                                  "https://calendar.duke.edu/assets/v2016/featured-event-3.png",
                                  "https://calendar.duke.edu/assets/v2016/featured-event-4.png",
                                  "https://calendar.duke.edu/assets/v2016/featured-event-5.png"]
        let randomNumber = Int.random(in: 0...3)
        return imageURLs[randomNumber]
    }
    
    /**
        Mutator method to assign formatted values to start_date, startmonth, startday, starttime, endtime
    **/
//        func simpTimeStamp(starttimestamp: String, endtimestamp: String){
//            let formatterInput = ISO8601DateFormatter()
//            if let date = formatterInput.date(from: starttimestamp){
//                let formatterOutput = DateFormatter()
//                formatterOutput.dateFormat = "MMM d, yyyy"
//                formatterOutput.locale = Locale(identifier: "en_US")
//                //formatterOutput.dateStyle = .short
//                //formatterOutput.timeStyle = .short
//                start_date = formatterOutput.string(from: date)
//                formatterOutput.dateFormat = "MMM"
//                startmonth = formatterOutput.string(from: date)
//                formatterOutput.dateFormat = "d"
//                startday = formatterOutput.string(from: date)
//                formatterOutput.dateFormat = "h:mm a"
//                starttime = formatterOutput.string(from: date)
//            }
//
//            if let date = formatterInput.date(from: endtimestamp){
//                let formatterOutput = DateFormatter()
//                formatterOutput.dateFormat = "MMM d, yyyy"
//                formatterOutput.locale = Locale(identifier: "en_US")
//                end_date = formatterOutput.string(from: date)
//                formatterOutput.dateFormat = "MMM"
//                formatterOutput.dateFormat = "h:mm a"
//                endtime = formatterOutput.string(from: date)
//            }
//
//        }

}
