//
//  APIManager.swift
//  DukeEventAttendanceApp
//
//  Created by Jessica Su on 4/11/20.
//  Copyright © 2020 Duke OIT. All rights reserved.
//

import Foundation
import Apollo

/**
 This class is responsible for handling all the GraphQL
 mutations and queries made to our backend database.
 */

class GraphQLManager {
    /**
        This query determines whether a single event has been
        marked active by the host or not.
    */
    func eventActive(eventid:String, nav:UINavigationController, completionHandler: @escaping (_ active: Bool, _ error: String?) -> Void ){
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
            }
        }
    }
    /**
        This query determines what kind of check-in (self check-in,
        QR check-in, self check-in around host) the host has
        enabled.
    */
    func checkInType(eventid:String, nav:UINavigationController, completionHandler: @escaping (_ checkInType: String, _ hostlat: String, _ hostlong: String, _ error: String?) -> Void ){
        let query = GetEventQuery(eventid: eventid)
        Apollo().getClient().fetch(query: query, cachePolicy: .returnCacheDataElseFetch) { [unowned self] results, error in
            if let error = error as? GraphQLHTTPResponseError {
                switch (error.response.statusCode) {
                case 401:
                    //request unauthorized due to bad token
                    OAuthService.shared.refreshToken(navController: nav) { success, statusCode in
                        if success {
                            self.checkInType(eventid: eventid, nav: nav){ checkInType, hostlat, hostlong, error in
                                completionHandler(checkInType, hostlat, hostlong, error)
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
                print( results?.data?.getEvent.checkintype ?? "no check in type" )
                completionHandler( (results?.data?.getEvent.checkintype)!, (results?.data?.getEvent.hostlat)!, (results?.data?.getEvent.hostlong)!, nil )
            }
        }
    }
    
    /**
        This mutation is performed when a host opens an event
        for check-in.
    */
    func openEvent(eventid:String, checkintype:String, hostlat: String, hostlong: String, nav: UINavigationController) -> Void {
        let openEventMutation = OpenEventMutation(eventid: eventid, checkintype: checkintype, hostlat: hostlat, hostlong: hostlong)
        Apollo().getClient().perform(mutation: openEventMutation) { [unowned self] result, error in
            if let error = error as? GraphQLHTTPResponseError {
                switch (error.response.statusCode) {
                case 401:
                    //request unauthorized due to bad token
                    OAuthService.shared.refreshToken(navController: nav) { success, statusCode in
                        if success {
                            self.openEvent(eventid: eventid, checkintype: checkintype, hostlat: hostlat, hostlong: hostlong, nav: nav)
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
                print(result?.data?.openEvent?.status ?? "no status")
            }
            
        }
    }
    
    /**
        Mutation that allows the host to close an event (make it inactive).
    */
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
                print(result?.data?.closeEvent?.status ?? "no close event status")
            }
            
        }
    }
    
    /**
        Gets DUID (card number) and name for a certain attendee.
    */
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
                completionHandler(data![3], data![1], nil)
                
            }
        }
    }
    
    /**
     Fetches events that are designated as active from server and adds them to variable activeEvents
     */
    func getActiveEvents(nav: UINavigationController, completionHandler: @escaping (_ activeEvents: [String], _ error: String?) -> Void){
        
        let query = GetActiveEventsQuery()
        Apollo().getClient().fetch(query: query, cachePolicy: .fetchIgnoringCacheData) { [unowned self] results, error in
            
            if let error = error as? GraphQLHTTPResponseError {
                switch (error.response.statusCode) {
                case 401:
                    //request unauthorized due to bad token
                    OAuthService.shared.refreshToken(navController: nav) { success, statusCode in
                        if success {
                            self.getActiveEvents(nav: nav) { activeEvents, error in
                                completionHandler(activeEvents, error)
                            }
                        } else {
                            //handle error
                        }
                    }
                default:
                    print (error.localizedDescription)
                }
            }
            else if let activeEvents = results?.data?.getActiveEvents{
                var actualEvents = [String]()
                for event in activeEvents {
                    actualEvents.append( event.resultMap["eventid"]!! as! String )
                }
                DispatchQueue.main.async {
                    completionHandler(actualEvents, nil)
                }
            } else{
                
            }
        }
    }
    
    /*
     GraphQL query that retrieves information about a user - name and
     time of check-in.
     */
    func getNameAndTime(nav: UINavigationController, cardNumber:String, event_id:String, completionHandler: @escaping (_ checkInInfo: [String:String], _ error: String?) -> Void ){
        let query = GetInfoQuery(eventid: event_id, attendeeid: cardNumber)
        Apollo().getClient().fetch(query: query, cachePolicy: .returnCacheDataElseFetch) { [unowned self] results, error in
            if let error = error as? GraphQLHTTPResponseError {
                switch (error.response.statusCode) {
                case 401:
                    //request unauthorized due to bad token
                    OAuthService.shared.refreshToken(navController: nav) { success, statusCode in
                        if success {
                            self.getNameAndTime(nav: nav, cardNumber: cardNumber, event_id:event_id) { checkInInfo, error in
                                completionHandler(checkInInfo, error)
                            }
                        } else {
                            //handle error
                        }
                    }
                default:
                    print ("error")
                }
            }
            else {
                let infoarr = results?.data?.resultMap["getInfo"] as! [String]
                let name = infoarr[1]
                let time = infoarr[0]
                completionHandler(["name": name,"time": time], nil)
                
            }
            
        }
    }
    
    /**
     
     TODO:
     - hostEventsQuery (HostTableViewController)
     - allAttendeesQuery (CurrentAttendeesTableViewController)
     - loadAttendee (QRScannerController)
     - loadAttendee (SelfCheckInViewController)
     - checkOutAttendee (SelfCheckInViewController)
    */
    
    
    
    
}
