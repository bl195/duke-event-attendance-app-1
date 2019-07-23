//
//  CurrentAttendeesTableViewController.swift
//  DukeEventAttendanceApp
//
//  Created by Luiza Wolf on 7/3/19.
//  Copyright © 2019 Duke OIT. All rights reserved.
//

import UIKit
import Apollo


class CurrentAttendeesTableViewController: UITableViewController {
    
    var event_id = ""
    var current_attendees = [String]()
    
    var refreshControl2: UIRefreshControl!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.barTintColor = UIColor(red:0.00, green:0.13, blue:0.41, alpha:1.0)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = UIColor.white
        //self.navigationController?.navigationBar.isOpaque = true
        
        // Register the custom header view.
        tableView.register(CustomHeader.self, forHeaderFooterViewReuseIdentifier: "sectionHeader")
        
        
        
        refreshControl2 = UIRefreshControl()
        refreshControl2!.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl2!.addTarget(self, action: #selector(doSomething), for: .valueChanged)
        tableView.addSubview(refreshControl2)
        
        let hnc = self.storyboard?.instantiateViewController(withIdentifier: "hostNav") as? UINavigationController
        loadAttendees(nav: hnc!) { attendees,error in
            self.current_attendees = attendees
            self.tableView.reloadData()
        }
        
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
    }
    
    @objc func goBack(){
        
    }
    
    @objc func doSomething(refreshControl: UIRefreshControl) {
        print("Hello World!")
        
        // somewhere in your code you might need to call:
        let hnc = self.storyboard?.instantiateViewController(withIdentifier: "hostNav") as? UINavigationController
        loadAttendees(nav: hnc!) {attendees,error in
            self.current_attendees = attendees
            self.tableView.reloadData()
        }
        refreshControl2.endRefreshing()
    }
    
    func loadAttendees(nav: UINavigationController, completionHandler: @escaping (_ attendees: [String],_ error: String?) -> Void){
        self.current_attendees.removeAll()
        let query = AllAttendeesQuery(id: self.event_id)
        Apollo().getClient().fetch(query: query, cachePolicy: .fetchIgnoringCacheData) { [unowned self] results, error in
            if let error = error as? GraphQLHTTPResponseError {
                switch (error.response.statusCode) {
                case 401:
                    //request unauthorized due to bad token
                    OAuthService.shared.refreshToken(navController: nav) { success, statusCode in
                        if success {
                            self.loadAttendees(nav: nav) { attendees, error in
                                completionHandler(attendees, error)
                            }
                        } else {
                            //handle error
                        }

                    }
                default:
                    print ("error")
                }
            }
            else if let attendees = results?.data?.allAttendees{
                for attendee in attendees {
                    self.current_attendees.append( attendee.resultMap["duid"]!! as! String )

                    //self.tableView.reloadData()
                }
                DispatchQueue.main.async {
                    completionHandler(self.current_attendees,nil)
                }
            } else{
                let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height))
                let messageLabel = UILabel(frame: rect)
                messageLabel.text = "No attendees have checked in yet"
                messageLabel.textColor = UIColor.black
                messageLabel.textAlignment = .center;
                messageLabel.font = UIFont(name: "Helvetica-Light", size: 22)
                messageLabel.sizeToFit()
                self.tableView.backgroundView = messageLabel
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.current_attendees.count
    }
    
//    func getName( cardNumber:String, completionHandler: @escaping (_ cardnumber: String) -> Void ){
//        let query = GetNameQuery(cardnumber: cardNumber)
//        Apollo.shared.client.fetch(query: query, cachePolicy: .returnCacheDataElseFetch) { [unowned self] results, error in            let name = results?.data?.resultMap["getName"] as! String
//            completionHandler(name)
//        }
//    }
    
    func getInfo(nav: UINavigationController, cardNumber:String, completionHandler: @escaping (_ cardnumber: [String:String], _ error: String?) -> Void ){
        let query = GetInfoQuery(eventid: self.event_id, attendeeid: cardNumber)
        Apollo().getClient().fetch(query: query, cachePolicy: .returnCacheDataElseFetch) { [unowned self] results, error in
            if let error = error as? GraphQLHTTPResponseError {
                switch (error.response.statusCode) {
                case 401:
                    //request unauthorized due to bad token
                    OAuthService.shared.refreshToken(navController: nav) { success, statusCode in
                        if success {
                            self.getInfo(nav: nav, cardNumber: cardNumber) { cardnumber, error in
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
            else {
                let infoarr = results?.data?.resultMap["getInfo"] as! [String]
                let name = infoarr[1]
                let time = infoarr[0]
                completionHandler(["name": name,"time": time], nil)
                
            }
            
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let name = "Loading Name..."
        let time = "..."
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrentAttendeeCell", for: indexPath) as! CurrentAttendeesTableViewCell
//        self.getName(cardNumber: current_attendees[indexPath.row]){ name in
//            cell.name.text = name
//        }
        let hnc = self.storyboard?.instantiateViewController(withIdentifier: "hostNav") as? UINavigationController
        
        self.getInfo(nav: hnc!, cardNumber: current_attendees[indexPath.row]){ dic,error in
            cell.name.text = dic["name"]
            cell.checkInTime.text = dic["time"]
        }
        cell.checkInTime.text = time
        cell.name.text = name
        cell.dukeCardNumber.text = "CARD: " + current_attendees[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView,
                            viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier:
            "sectionHeader") as! CustomHeader
        let event = Items.sharedInstance.eventArray.first(where: { $0.id == event_id })
        view.title.attributedText = NSAttributedString(string: event!.summary, attributes: [NSAttributedString.Key.font: UIFont(name: "Helvetica-Bold", size: 23)!, NSAttributedString.Key.foregroundColor: UIColor.white])
        view.title.numberOfLines = 2
        view.checkintime.attributedText = NSAttributedString(string: "Start Check-In: " + event!.starttime, attributes: [NSAttributedString.Key.font: UIFont(name: "Helvetica-Light", size: 18)!, NSAttributedString.Key.foregroundColor: UIColor.white])
        view.checkintime.numberOfLines = 0
        view.title.textAlignment = .center
        
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 130
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
