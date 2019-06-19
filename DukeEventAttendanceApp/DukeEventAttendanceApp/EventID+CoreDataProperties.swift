//
//  EventID+CoreDataProperties.swift
//  DukeEventAttendanceApp
//
//  Created by Luiza Wolf on 6/19/19.
//  Copyright © 2019 Duke OIT. All rights reserved.
//
//

import Foundation
import CoreData


extension EventID {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EventID> {
        return NSFetchRequest<EventID>(entityName: "EventID")
    }

    @NSManaged public var id: String?

}
