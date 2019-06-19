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
    var filtername = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.loadSampleEvents(filter: filtername)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    private func loadSampleEvents(filter: String){
        let filtername1 = filter.replacingOccurrences(of: " ", with: "+")
        filtername = "&topic=" + filtername1
        filtername.replacingOccurrences(of: "/", with: "%2F")
        filtername.replacingOccurrences(of: "&", with: "%26")
        var day_range = "90"
        //var filter = "" //&gfu[]=Career%20Center"
        /*
        if filter == "Home" {
            filtername = ""
        }
 */
        var spec_url = "https://calendar.duke.edu/events/index.json?" + filtername + "&future_days=" + day_range + "&feed_type=simple"
        
        NetworkManager.downloadCalendarInfo(specific_url: spec_url) { jsonData in
            
            if let events = jsonData["events"] as? Array<Dictionary<String,Any>>{
                
                for event in events{
  
//                    guard let event0 = Event(id: event["id"] as? String ?? "",
//                                             start_date: event["start_timestamp"] as? String ?? "",
//                                             end_date: event["end_timestamp"] as? String ?? "",
//                                             summary: event["summary"] as? String ?? "",
//                                             description: event["description"] as? String ?? "",
//                                             status: event["status"] as? String ?? "",
//                                             sponsor: event["sponsor"] as? String ?? "",
//                                             co_sponsors: event["co_sponsors"] as? String ?? "",
//                                             location: event["location"] as! Dictionary<String,String>,
//                                             contact: event["contact"] as! Dictionary<String,String>,
//                                             categories: event["categories"] as? [String] ?? ["no category"],
//                                             link: event["link"] as? String ?? "",
//                                             event_url: event["event_url"] as? String ?? "",
//                                             series_name: event["series_name"] as? String ?? "",
//                                             image_url: event["image"] as? String ?? "")
//                        else{
//                            fatalError("Unable to instantiate event")
//                    }
                    
                    
                    func getRandomImageURL() -> String{
                        let imageURLs:[String] = ["https://calendar.duke.edu/assets/v2016/featured-event-4.png",
                                                  "https://calendar.duke.edu/assets/v2016/featured-event-3.png",
                                                  "https://calendar.duke.edu/assets/v2016/featured-event-4.png",
                                                  "https://calendar.duke.edu/assets/v2016/featured-event-5.png"]
                        let randomNumber = Int.random(in: 0...3)
                        return imageURLs[randomNumber]
                    }
                    
                    let event0 = Event(context: PersistenceService.context)
                    event0.id = event["id"] as? String ?? ""
                    event0.start_date = event["start_timestamp"] as? String ?? ""
                    event0.end_date = event["end_timestamp"] as? String ?? ""
                    event0.summary = event["summary"] as? String ?? ""
                    event0.status = event["status"] as? String ?? ""
                    event0.sponsor = event["sponsor"] as? String ?? ""
                    event0.co_sponsors = event["co_sponsors"] as? String ?? ""
                    let locationDict = event["location"] as! Dictionary<String,String>
                    event0.maps_link = locationDict["link"] as? String ?? ""
                    event0.address = locationDict["address"] as? String ?? ""
                    let contact = event["contact"] as! Dictionary<String,String>
                    event0.contact_name = contact["name"] as? String ?? ""
                    event0.contact_email = contact["email"] as? String ?? ""
                    event0.duke_cal_link = event["link"] as? String ?? ""
                    event0.ext_event_link = event["event_url"] as? String ?? ""
                    event0.series_name = event["series_name"] as? String ?? ""
                    var image_url = event["image"] as? String ?? ""
                    if( image_url != ""){
                        event0.image_url = image_url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                    }
                    else{
                        event0.image_url = getRandomImageURL()
                    }
                    event0.desc = event["description"] as? String ?? ""
                    
                    func simpTimeStamp(starttimestamp: String, endtimestamp: String){
                        let formatterInput = ISO8601DateFormatter()
                        if let date = formatterInput.date(from: starttimestamp){
                            let formatterOutput = DateFormatter()
                            formatterOutput.dateFormat = "MMM d, yyyy"
                            formatterOutput.locale = Locale(identifier: "en_US")
                            //formatterOutput.dateStyle = .short
                            //formatterOutput.timeStyle = .short
                            event0.start_date = formatterOutput.string(from: date)
                            formatterOutput.dateFormat = "MMM"
                            event0.start_month = formatterOutput.string(from: date)
                            formatterOutput.dateFormat = "d"
                            event0.start_day = formatterOutput.string(from: date)
                            formatterOutput.dateFormat = "h:mm a"
                            event0.start_time = formatterOutput.string(from: date)
                        }
                
                        if let date = formatterInput.date(from: endtimestamp){
                            let formatterOutput = DateFormatter()
                            formatterOutput.dateFormat = "MMM d, yyyy"
                            formatterOutput.locale = Locale(identifier: "en_US")
                            event0.end_date = formatterOutput.string(from: date)
                            formatterOutput.dateFormat = "MMM"
                            formatterOutput.dateFormat = "h:mm a"
                            event0.end_time = formatterOutput.string(from: date)
                        }
                
                    }
                
                    simpTimeStamp(starttimestamp: event["start_timestamp"] as! String, endtimestamp: event["end_timestamp"] as! String)
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
        if let imageUrl = URL(string: event.image_url!) {
            // This is a network call and needs to be run on non-UI thread
            DispatchQueue.global().async {
                let imageData = try! Data(contentsOf: imageUrl)
                let image = UIImage(data: imageData)
                DispatchQueue.main.async {
                    cell.photoImageView.image = image
                }
            }
        }
        //cell.photoImageView.image = event.getImage()
        
        // scell.photoImageView.contentMode = UIView.ContentMode.center
        cell.photoImageView.contentMode = UIView.ContentMode.scaleAspectFill
        cell.photoImageView.layer.cornerRadius = 10.0
        cell.photoImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        cell.photoImageView.clipsToBounds = true
        
        cell.backgroundCard.layer.cornerRadius = 10.0
        cell.backgroundCard.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        cell.backgroundCard.clipsToBounds = true
        
        //cell.photoImageView.clipsToBounds = true
        cell.dateLabel.text = event.start_date
        cell.locationLabel.text = event.address
        
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "EventInfoViewController") as? EventInfoViewController
        vc?.sum = self.eventArray[indexPath.row].summary!
        vc?.sdl = self.eventArray[indexPath.row].start_day!
        vc?.sml = self.eventArray[indexPath.row].start_month!
        vc?.ll = self.eventArray[indexPath.row].address!
        vc?.imageURL = self.eventArray[indexPath.row].image_url!
        vc?.tl = self.eventArray[indexPath.row].start_time! + " - " + self.eventArray[indexPath.row].end_time!
        vc?.dl = self.eventArray[indexPath.row].desc!
        vc?.ldl = self.eventArray[indexPath.row].start_date!
        vc?.sl = self.eventArray[indexPath.row].sponsor!
        
        self.navigationController?.pushViewController(vc!, animated: true)
        //present(vc!, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let agendaAction = UITableViewRowAction(style: .default, title: "Add to Agenda"){[weak self] (_, indexPath) in
            guard let agendaEvent = self?.eventArray[indexPath.row] else{
                return
            }
            //let ev = self?.eventArray[indexPath.row]
            var ev = Event(context: PersistenceService.context)
            ev.address = agendaEvent.address
            ev.co_sponsors = agendaEvent.co_sponsors
            ev.contact_email = agendaEvent.contact_email
            ev.contact_name = agendaEvent.contact_name
            ev.desc = agendaEvent.desc
            ev.duke_cal_link = agendaEvent.duke_cal_link
            
            
            PersistenceService.saveContext()
            Items.sharedInstance.agendaEvents.append(agendaEvent)
            print("appended " + agendaEvent.summary!)
        }
        //self.tableView.reloadData()
        return [agendaAction]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
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

