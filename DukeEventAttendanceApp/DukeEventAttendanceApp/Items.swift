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
    
    
    func getCard(completionHandler: @escaping (_ cardnumber: String) -> Void ){
        let query = GetCardQueryQuery()
        Apollo.shared.client.fetch(query: query, cachePolicy: .returnCacheDataElseFetch) { [unowned self] results, error in
            //print(results)
            //print (results?.data?.getDukeCardNumber)
            if (results?.data?.getDukeCardNumber != nil ) {
                print("HERE")
                self.my_dukecardnumber = results?.data?.getDukeCardNumber ?? ""
                print(self.my_dukecardnumber)
                completionHandler(self.my_dukecardnumber)
            }
        }
    }
    
    
    
    //let my_netid = "ahw26"
    
    
    
    //let jess_netid = "js803"
}
