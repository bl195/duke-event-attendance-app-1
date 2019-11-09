//
//  SelfCheckInHelperMethods.swift
//  DukeEventAttendanceApp
//
//  Created by codeplus on 11/8/19.
//  Copyright © 2019 Duke OIT. All rights reserved.
//

import Foundation
import UIKit
import Apollo

class SelfCheckInHelperMethods{
    
    func loadAttendee (nav: UINavigationController, event_id: String) -> UIAlertController{
        //indicator.startAnimating()
        print (event_id)
        let createAttendeeMutation = SelfCheckInMutation(eventid: event_id)
        var alert = UIAlertController()
//        Apollo().getClient().perform(mutation: createAttendeeMutation) { [unowned self] result, error in
//            if let error = error as? GraphQLHTTPResponseError  {
//                switch (error.response.statusCode) {
//                case 401:
//                    //request unauthorized due to bad token
//
//                    OAuthService.shared.refreshToken(navController: nav) { success, statusCode in
//                        if success {
//                            self.loadAttendee(nav: nav, event_id: event_id)
//                        } else {
//                            //handle error
//                        }
//
//                    }
//                default:
//                    print ("error")
//                }
//            }
//            else if (result?.data?.selfCheckIn?.id != nil) {
//                print(result?.data?.selfCheckIn?.id ?? "no attendee")
//                let alert = UIAlertController(title: "You have successfully checked in", message: "", preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
//                //self.present(alert, animated: true)
//                //return alert
////                self.blueBackground.isHidden = true
////                self.whiteBackground.isHidden = true
////                self.eventLocationLabel.isHidden = true
////                self.eventTime.isHidden = true
////                self.confirmButton.isHidden = true
////                self.eventTitle.isHidden = true
//            }
//            else {
//                //guard for TWO KINDS OF ERRORS: 1) not valid student and 2) already checked in
//                alert = self.invalidityCheck(event_id: event_id)
//            }
//
//        }
        alert = UIAlertController(title: "You have successfully checked in", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        return alert
        
    }
    
    func invalidityCheck(event_id:String) -> UIAlertController{
            var alertMessage = ""
            var alert = UIAlertController()
            let query = AllAttendeesQuery(id: event_id)
            Apollo().getClient().fetch(query: query, cachePolicy: .fetchIgnoringCacheData) { [unowned self] results, error in
                if let attendees = results?.data?.allAttendees{
                    for attendee in attendees {
                        var att = attendee.resultMap["duid"]!! as! String
                        if( att == Items.sharedInstance.my_dukecardnumber ) { //needs to be changed
                            alertMessage = "You have already checked in"
                        } else {
                            alertMessage = "Your card number is invalid or the host has not opened the event for check-in"
                        }
                    }
                }
                alert = UIAlertController(title: "Your check-in cannot be validated", message: alertMessage, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                //self.present(alert, animated: true)
                //return alert
            }
        return alert
        }

}
