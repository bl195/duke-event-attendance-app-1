//
//  Items.swift
//  DukeEventAttendanceApp
//
//  Created by Jessica Su on 6/16/19.
//  Copyright © 2019 Duke OIT. All rights reserved.
//

import Foundation

class Items {
    static let sharedInstance = Items()
    
    var id_event_dict = [String:Event]()
    
    var eventArray = [Event]()
    var agendaEvents = [Event]()
}
