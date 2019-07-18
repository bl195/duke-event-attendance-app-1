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
    //private var my_dukecardnumber = ""
    var my_dukecardnumber = ""
    
    
    
    func getCard(nav: UINavigationController, completionHandler: @escaping (_ cardnumber: String, _ error: String?) -> Void ){
        let query = GetCardQueryQuery()
        Apollo().getClient().fetch(query: query, cachePolicy: .returnCacheDataElseFetch) { [unowned self] results, error in
            //print(results)
            //print (results?.data?.getDukeCardNumber)
            if let error = error as? GraphQLHTTPResponseError {
                switch (error.response.statusCode) {
                case 401:
                    //request unauthorized due to bad token
                    
                    OAuthService.shared.refreshToken(navController: nav) { success, statusCode in
                        if success {
                            
                            self.getCard(nav: nav) { cardnumber, error in
                                completionHandler(cardnumber, error)
                            }
                        } else {
                            //handle error
                        }
                        
                    }
                default:
                    print ("error")
                }
            }
            else if (results?.data?.getDukeCardNumber != nil ) {
                print("HERE")
                self.my_dukecardnumber = results?.data?.getDukeCardNumber ?? ""
                print(self.my_dukecardnumber)
                completionHandler(self.my_dukecardnumber, nil)
            }
        }
    }
    
    func getName(nav: UINavigationController, completionHandler: @escaping (_ returnname: String,_ error:String?) -> Void ){
        let query = GetMyNameQuery()
        Apollo().getClient().fetch(query: query, cachePolicy: .returnCacheDataElseFetch) { [unowned self] results, error in
            if let error = error as? GraphQLHTTPResponseError {
                switch (error.response.statusCode) {
                case 401:
                    //request unauthorized due to bad token
                    
                    OAuthService.shared.refreshToken(navController: nav) { success, statusCode in
                        if success {
                            
                            self.getName(nav: nav) { returnname, error in
                                completionHandler(returnname, error)
                            }
                        } else {
                            //handle error
                        }
                        
                    }
                default:
                    print ("error")
                }
            }
            else if (results?.data?.getMyname != nil) {
                let name = results?.data?.getMyname ?? ""
                completionHandler(name, nil)
            }
        }
    }
    
    func getDuid (nav: UINavigationController, completionHandler: @escaping (_ duid: String,_ error:String?) -> Void) {
        let query = GetDukeUniqueQuery()
        Apollo().getClient().fetch(query: query, cachePolicy: .returnCacheDataElseFetch) { [unowned self] results, error in
            if let error = error as? GraphQLHTTPResponseError {
                switch (error.response.statusCode) {
                case 401:
                    //request unauthorized due to bad token
                    
                    OAuthService.shared.refreshToken(navController: nav) { success, statusCode in
                        if success {
                            
                            self.getDuid(nav: nav) { duid, error in
                                completionHandler(duid, error)
                            }
                        } else {
                            //handle error
                        }
                        
                    }
                default:
                    print ("error")
                }
            }
            else if (results?.data?.getDuid != nil) {
                let duid = results?.data?.getDuid ?? ""
                completionHandler(duid,nil)
            }
            
            
        }
    }
    
   
}
