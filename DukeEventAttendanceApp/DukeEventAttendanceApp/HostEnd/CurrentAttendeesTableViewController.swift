//
//  CurrentAttendeesTableViewController.swift
//  DukeEventAttendanceApp
//
//  Created by Luiza Wolf on 7/3/19.
//  Copyright © 2019 Duke OIT. All rights reserved.
//

import UIKit


class CurrentAttendeesTableViewController: UITableViewController {
    
    var event_id = ""
    var current_attendees = [String]()
    
    var refreshControl2: UIRefreshControl!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl2 = UIRefreshControl()
        refreshControl2!.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl2!.addTarget(self, action: #selector(doSomething), for: .valueChanged)
        tableView.addSubview(refreshControl2)
        
        loadAttendees()
        
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
    }
    
    @objc func doSomething(refreshControl: UIRefreshControl) {
        print("Hello World!")
        
        // somewhere in your code you might need to call:
        loadAttendees()
        refreshControl2.endRefreshing()
    }
    
    func loadAttendees(){
        self.current_attendees.removeAll()
        let query = AllAttendeesQuery(id: self.event_id)
        Apollo.shared.client.fetch(query: query, cachePolicy: .fetchIgnoringCacheData) { [unowned self] results, error in
            //            print("got here")
            //            print("event id is " + self.event_id)
            if let attendees = results?.data?.allAttendees{
                for attendee in attendees {
                    self.current_attendees.append( attendee.resultMap["duid"]!! as! String )
                    //                    print( attendee.resultMap["duid"]!! as! String )
                    self.tableView.reloadData()
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
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrentAttendeeCell", for: indexPath) as! CurrentAttendeesTableViewCell

        // Configure the cell...
        cell.dukeCardNumber.text = current_attendees[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
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
