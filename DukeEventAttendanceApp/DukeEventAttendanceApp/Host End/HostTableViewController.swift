//
//  HostTableViewController.swift
//  DukeEventAttendanceApp
//
//  Created by Luiza Wolf on 7/2/19.
//  Copyright © 2019 Duke OIT. All rights reserved.
//
import UIKit
import Apollo


class HostTableViewController: UITableViewController, HostTableViewCellDelegate {

    var host_events = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true        
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.delegate = self
        tableView.dataSource = self
        getQuery()
        
        // Register the custom header view.
        tableView.register(CustomHeader.self,
                           forHeaderFooterViewReuseIdentifier: "sectionHeader")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func getQuery(){
        let query = HostsEventsQuery(id: Items.sharedInstance.my_netid)
        Apollo.shared.client.fetch(query: query, cachePolicy: .fetchIgnoringCacheData) { [unowned self] results, error in
            
            if let hostevents = results?.data?.hostEvents{
                for event in hostevents {
                    self.host_events.append( event.resultMap["eventid"]!! as! String )
                    self.tableView.reloadData()
                }
                
            } else{
                let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height))
                let messageLabel = UILabel(frame: rect)
                messageLabel.text = "You are not hosting any events"
                messageLabel.textColor = UIColor.black
                messageLabel.textAlignment = .center;
                messageLabel.font = UIFont(name: "Helvetica-Light", size: 22)
                messageLabel.sizeToFit()
                self.tableView.backgroundView = messageLabel
            }
        }
    }
    
    //Delegate method
    func didTapAllowCheckIn(eventid:String) {
        let alert = UIAlertController(title: "Choose Check-In Method", message: "Please choose method by which attendees will check in to your event", preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "QR Code", style: .default, handler: {(action) -> Void in
            let qvc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "QRCodeViewController") as? QRCodeViewController
            //self.navigationController?.pushViewController(vc!, animated: true)
            qvc?.event_id = eventid
            self.navigationController?.show(qvc!, sender: true)
            //self.performSegue(withIdentifier: "vc2", sender: self)
        } ) )
        
        alert.addAction( UIAlertAction(title: "Self Check-In", style: .default, handler: {(action) -> Void in
                       let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CurrentAttendees") as? CurrentAttendeesTableViewController
                        //self.navigationController?.pushViewController(vc!, animated: true)
            vc?.event_id = eventid
            self.navigationController?.show(vc!, sender: true)
            //self.performSegue(withIdentifier: "vc2", sender: self)
        } ) )
        alert.addAction( UIAlertAction(title: "Cancel", style: .cancel, handler: nil) )
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
//    // Create a standard header that includes the returned text.
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection
//        section: Int) -> String? {
//
//        return "Header \(section)"
//    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier:
            "sectionHeader") as! CustomHeader
        view.month.text = "\(section)" //sections[section]
        return view
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

        cell.delegate = self
        cell.setEvent(event: event ?? Event.init(id: "", start_date: "", end_date: "", summary: "", description: "", status: "", sponsor: "", co_sponsors: "", location: ["":""], contact: ["":""], categories: [""], link: "", event_url: "", series_name: "", image_url: "")!)
        
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
