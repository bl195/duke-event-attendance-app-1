//
//  Items.swift
//  DukeEventAttendanceApp
//
//  Created by Luiza Wolf on 6/19/19.
//  Copyright © 2019 Duke OIT. All rights reserved.
//

import Foundation
import Apollo

class Items{
    static let sharedInstance = Items()
    var eventArray = [Event]()
    var id_event_dict = [String:Event]()
    var duid = ""
    var hostLocLat = ""
    var hostLocLong = ""
    
    
    func eventActive(eventid:String, nav:UINavigationController, completionHandler: @escaping (_ active: Bool, _ error: String?) -> Void ){
        if nav == nil {
            return
        }
        let query = GetEventQuery(eventid: eventid)
        Apollo().getClient().fetch(query: query, cachePolicy: .returnCacheDataElseFetch) { [unowned self] results, error in
            if let error = error as? GraphQLHTTPResponseError {
                switch (error.response.statusCode) {
                case 401:
                    //request unauthorized due to bad token
                    OAuthService.shared.refreshToken(navController: nav) { success, statusCode in
                        if success {
                            self.eventActive(eventid: eventid, nav: nav){ active, error in
                                completionHandler(active, error)
                            }
                        } else {
                            //handle error
                        }
                    }
                default:
                    print (error.localizedDescription)
                }
            }
            else if (results?.data?.getEvent != nil ) {
                if( results?.data?.getEvent.status == "inactive"){
                    completionHandler(false, nil)
                } else{
                    completionHandler(true, nil)
                }
            } //else {
//                completionHandler(false, nil)
//            }
        }
    }
    
    func checkInType(eventid:String, nav:UINavigationController, completionHandler: @escaping (_ checkInType: String, _ error: String?) -> Void ){
        let query = GetEventQuery(eventid: eventid)
        Apollo().getClient().fetch(query: query, cachePolicy: .returnCacheDataElseFetch) { [unowned self] results, error in
            if let error = error as? GraphQLHTTPResponseError {
                switch (error.response.statusCode) {
                case 401:
                    //request unauthorized due to bad token
                    OAuthService.shared.refreshToken(navController: nav) { success, statusCode in
                        if success {
                            self.checkInType(eventid: eventid, nav: nav){ checkInType, error in
                                completionHandler(checkInType, error)
                            }
                        } else {
                            //handle error
                        }
                    }
                default:
                    print ("error")
                }
            }
            else if (results?.data?.getEvent != nil ) {
                print( results?.data?.getEvent.checkintype )
                completionHandler( (results?.data?.getEvent.checkintype)!, nil )
            }
        }
    }
    
    func openEvent(eventid:String, checkintype:String, nav: UINavigationController) -> Void {
        let openEventMutation = OpenEventMutation(eventid: eventid, checkintype: checkintype)
        Apollo().getClient().perform(mutation: openEventMutation) { [unowned self] result, error in
            if let error = error as? GraphQLHTTPResponseError {
                switch (error.response.statusCode) {
                case 401:
                    //request unauthorized due to bad token
                        OAuthService.shared.refreshToken(navController: nav) { success, statusCode in
                        if success {
                            self.openEvent(eventid: eventid, checkintype: checkintype, nav: nav)
                        } else {
                            //handle error
                        }
                    }
                default:
                    print ("error")
                }
            }
            else if (result?.data?.openEvent?.status != nil) {
                print("success")
                print(result?.data?.openEvent?.status)
                //print(result?.data?.openEvent?.checkintype)
            }
            
        }
    }
    
    func closeEvent(eventid:String, nav: UINavigationController) -> Void {
        let closeEventMutation = CloseEventMutation(eventid: eventid)
        Apollo().getClient().perform(mutation: closeEventMutation) { [unowned self] result, error in
            if let error = error as? GraphQLHTTPResponseError {
                switch (error.response.statusCode) {
                case 401:
                    //request unauthorized due to bad token
                    OAuthService.shared.refreshToken(navController: nav) { success, statusCode in
                        if success {
                            self.closeEvent(eventid: eventid, nav: nav)
                        } else {
                            //handle error
                        }
                    }
                default:
                    print ("error")
                }
            }
            else if (result?.data?.closeEvent?.status != nil) {
                print("success")
                print(result?.data?.closeEvent?.status)
            }
            
        }
    }
    
    func getInfo(nav: UINavigationController, completionHandler: @escaping (_ duid: String, _ name: String, _ error: String?) -> Void ){
        let query = GetMyInfoQuery()
        Apollo().getClient().fetch(query: query, cachePolicy: .returnCacheDataElseFetch) { [unowned self] results, error in
            if let error = error as? GraphQLHTTPResponseError {
                switch (error.response.statusCode) {
                case 401:
                    //request unauthorized due to bad token
                    OAuthService.shared.refreshToken(navController: nav) { success, statusCode in
                        if success {
                            
                            self.getInfo(nav: nav) { duid, name, error in
                                completionHandler(duid, name, error)
                            }
                        } else {
                            //handle error
                        }
                        
                    }
                default:
                    print ("error")
                }
            }
            else if (results?.data?.getMyInfo != nil ) {
                let data = results?.data?.getMyInfo
                self.duid = data![3]
                print("HERE")
                print(data)
                completionHandler(data![3], data![1], nil)
                
            }
        }
    }
    
   
}
