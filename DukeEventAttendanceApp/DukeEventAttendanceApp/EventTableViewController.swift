//
//  EventTableViewController.swift
//  DukeEventAttendanceApp
//
//  Created by Luiza Wolf on 6/6/19.
//  Copyright © 2019 Duke OIT. All rights reserved.
//

import UIKit

class EventTableViewController: UITableViewController {
    
    var eventArray = [Event]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.loadSampleEvents()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    private func loadSampleEvents(){
        
        NetworkManager.downloadCalendarInfo { jsonData in
            
            if let events = jsonData["events"] as? Array<Dictionary<String,Any>>{
                
                for event in events{
                    
                    var date_beg:String = ""
                    if let start_time = event["start_timestamp"] as? String{
                        let formatterInput = ISO8601DateFormatter()
                        if let date = formatterInput.date(from: start_time){
                            let formatterOutput = DateFormatter()
                            //formatterOutput.dateFormat = "d"
                            formatterOutput.locale = Locale(identifier: "en_US")
                            formatterOutput.dateStyle = .short
                            formatterOutput.timeStyle = .short
                            date_beg = formatterOutput.string(from: date)
                        }
                    }
                    
                    var date_end:String = ""
                    if let start_time = event["end_timestamp"] as? String{
                        let formatterInput = ISO8601DateFormatter()
                        if let date = formatterInput.date(from: start_time){
                            let formatterOutput = DateFormatter()
                            formatterOutput.dateFormat = "d"
                            formatterOutput.locale = Locale(identifier: "en_US")
                            formatterOutput.dateStyle = .short
                            formatterOutput.timeStyle = .short
                            date_end = formatterOutput.string(from: date)
                        }
                    }
                    
                    
                    guard let event0 = Event(id: event["id"] as? String ?? "",
                                             start_time: date_beg,
                                             end_time: date_end,
                                             summary: event["summary"] as? String ?? "",
                                             description: event["description"] as? String ?? "",
                                             status: event["status"] as? String ?? "",
                                             sponsor: event["sponsor"] as? String ?? "",
                                             co_sponsors: event["co_sponsors"] as? String ?? "",
                                             location: event["location"] as! Dictionary<String,String>,
                                             contact: event["contact"] as! Dictionary<String,String>,
                                             categories: event["categories"] as? [String] ?? ["no category"],
                                             link: event["link"] as? String ?? "",
                                             event_url: event["event_url"] as? String ?? "",
                                             series_name: event["series_name"] as? String ?? "",
                                             image_url: event["image"] as? String ?? "")
                        else{
                            fatalError("Unable to instantiate event")
                    }
                    
                    self.eventArray.append( event0 )
                    
                }
                
                // Downloading data from network is asynchronous, after download is done, need to inform table view to reload data to refresh UI.
                // UI refresh needs to happen on main UI thread and the completion handler is already called on main thread.
                //DispatchQueue.main.async() {
                self.tableView.reloadData()
                //}
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return eventArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EventTableViewCell", for: indexPath) as? EventTableViewCell else{
            fatalError("the cell is not an instance of the table view cell")
        }
        // Configure the cell...
        let event = self.eventArray[indexPath.row]
        cell.nameLabel.text = event.summary
        
        // Need to check if url can be created successfully
        //if let imageUrl = URL(string: event.image_url) {
        //  TESTING with a fixed image url as event's image_url is empty
        if let imageUrl = URL(string: event.image_url) {
            // This is a network call and needs to be run on non-UI thread
            DispatchQueue.global().async {
                let imageData = try! Data(contentsOf: imageUrl)
                let image = UIImage(data: imageData)
                DispatchQueue.main.async {
                    cell.photoImageView.image = image
                }
            }
        }
        //cell.photoImageView.contentMode = UIView.ContentMode.scaleAspectFill
        //cell.photoImageView.clipsToBounds = true
        cell.dateLabel.text = event.start_time
        cell.locationLabel.text = event.address
        
        
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

