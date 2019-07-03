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
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.delegate = self
        tableView.dataSource = self
        
        let query = HostsEventsQuery(id: "ahw26")
        Apollo.shared.client.fetch(query: query, cachePolicy: .fetchIgnoringCacheData) { [unowned self] results, error in
            if let hostevents = results?.data?.hostEvents{
                for event in hostevents {
                    self.host_events.append( event.resultMap["eventid"]!! as! String )
                    self.tableView.reloadData()
                }
            } else{
                //print("no host events")
                let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height))
                let messageLabel = UILabel(frame: rect)
                messageLabel.text = "You are not hosting any events"
                messageLabel.textColor = UIColor.black
                messageLabel.textAlignment = .center;
                messageLabel.font = UIFont(name: "Helvetica-Light", size: 22)
                messageLabel.sizeToFit()
                self.tableView.backgroundView = messageLabel
            }
            
            //self.tableView.reloadData()
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
        let event_id = self.host_events[indexPath.row]
        let event = Items.sharedInstance.eventArray.first(where: { $0.id == event_id })
        if event != nil{
            cell.eventTitle.text = event?.summary
            cell.monthLabel.text = event?.startmonth.uppercased()
            cell.dayLabel.text = event?.startday
            cell.timeLabel.text = "Time: " + event!.starttime + " - " + event!.endtime
            cell.locLabel.text = "Location: " + event!.address
        }
        cell.backgroundCard.layer.cornerRadius = 10.0
        cell.allowCheckInButton.layer.cornerRadius = 10.0
        
        cell.allowCheckInAction = { [unowned self] in
           let alert = UIAlertController(title: "Choose Check-in Method", message: "This is the method guests will use to check in to your event", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "QR Code", style: .default, handler: nil))
            alert.addAction( UIAlertAction(title: "Self Check-In", style: .default, handler: { action in
                //let controller = self.storyboard?.instantiateViewController(withIdentifier: "ViewController")
                //self.navigationController?.pushViewController(controller!, animated: true)
                //self.performSegue(withIdentifier: "ViewController", sender: self)
                
            } ) )
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
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
