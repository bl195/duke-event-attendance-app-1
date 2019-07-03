//
//  HostTableViewController.swift
//  DukeEventAttendanceApp
//
//  Created by Luiza Wolf on 7/2/19.
//  Copyright © 2019 Duke OIT. All rights reserved.
//
import UIKit
import Apollo

class HostTableViewController: UITableViewController {
    
    var host_events = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "HostTableViewCell", bundle: nil), forCellReuseIdentifier: "HostTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        
                let query = HostsEventsQuery(id: "ahw26")
                Apollo.shared.client.fetch(query: query, cachePolicy: .fetchIgnoringCacheData) { [unowned self] results, error in
                    let hostevents = results?.data?.hostEvents
                    for event in hostevents! {
                    self.host_events.append( event.resultMap["eventid"]!! as! String )
                }
                self.tableView.reloadData()
        }
        
        
    }

    
//   func queryHostEvents() {
//        let query = HostsEventsQuery(id: "ahw26")
//        Apollo.shared.client.fetch(query: query, cachePolicy: .fetchIgnoringCacheData) { [unowned self] results, error in
//            let hostevents = results?.data?.hostEvents
//            for event in hostevents! {
//            self.host_events.append( event.resultMap["eventid"]!! as! String )
//        }
//        self.tableView.reloadData()
//    }
//
//  }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.host_events.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "please", for: indexPath) as? HostTableViewCell else{
            fatalError("the cell is not an instance of the table view cell")
        }
        // Configure the cell...
        let event_title = self.host_events[indexPath.row]
        cell.eventTitle.text = event_title

        let event = Items.sharedInstance.eventArray.first(where: { $0.id == event_title })
        print(event?.summary)
        return cell
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
