//
//  MyAgendaTableViewController.swift
//  DukeEventAttendanceApp
//
//  Created by Luiza Wolf on 6/13/19.
//  Copyright © 2019 Duke OIT. All rights reserved.
//

import UIKit
import CoreData


class MyAgendaTableViewController: UITableViewController, AgendaTableViewCellDelegate {
    
    func didTapCheckIn(event: Event) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "checkInOption") as? CheckInOptionViewController
        vc?.eventLoc = event.address
        vc?.eventID = event.id
        vc?.event = event
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    var agendaEvents: [Event] = []
    var months = [String]()
    var month_events = [String: [Event]]()
    
    override func viewDidLoad() {
        self.title = "My Agenda"
        super.viewDidLoad()
        
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.tableView.delegate = self //maybe
        self.tableView.dataSource = self //maybe
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        self.tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        super.viewWillAppear(animated)
        
        let fetchRequest: NSFetchRequest<EventID> = EventID.fetchRequest()
        
        do {
            let agendaArray = try PersistenceService.context.fetch(fetchRequest)
            agendaEvents.removeAll()
            var globalagendaEvents = Items.sharedInstance.eventArray
            var globalEventDict = Items.sharedInstance.id_event_dict
            for id in agendaArray{
                if globalEventDict.keys.contains(id.id!){
                    var ev = globalEventDict[id.id!]!
                    if( agendaEvents.contains(ev) == false){
                        agendaEvents.append(ev)
                    }
                    if( !self.months.contains( ev.longmonth )){
                        self.months.append(ev.longmonth)
                        self.month_events[ev.longmonth] = [Event]()
                    }
                    self.month_events[ev.longmonth]?.append(ev)
                }
            }
            var index = 0
            
        } catch {}
        agendaEvents = agendaEvents.sorted(by: { $0.sorted_date.compare($1.sorted_date) == .orderedAscending} )
        
        // Register the custom header view.
        tableView.register(MonthCustomHeader.self,
                           forHeaderFooterViewReuseIdentifier: "MonthCustomHeader")
        
        self.tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.months.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier:
            "MonthCustomHeader") as! MonthCustomHeader
        //view.customLabel.text = self.months[section]
        view.customLabel.attributedText = NSAttributedString(string: self.months[section].uppercased(), attributes: [NSAttributedString.Key.kern: 5.0, NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 18)!, NSAttributedString.Key.foregroundColor: UIColor(red:0.00, green:0.13, blue:0.41, alpha:1.0)])
        return view
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.month_events[months[section]]!.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AgendaTableViewCell", for: indexPath) as? AgendaTableViewCell else {
            fatalError ("the cell is not an instance of agenda table view cell")
        }
        
        // Configure the cell...
        
        let agendaEv = self.month_events[months[indexPath.section]]![indexPath.row]

        
//        @objc func sendtoDB(sender: UIButton) {
//            print ("yay")
//        }
//
//        cell.checkInButton.addTarget(self, action:#selector(sendtoDB(sender:)), for: .touchUpInside)
        
        cell.backgroundCard.layer.backgroundColor = UIColor(white: 1.0, alpha: 0.0).cgColor
        cell.backgroundCard.layer.borderWidth = 1
        cell.backgroundCard.layer.borderColor = UIColor(red: 0/255.0, green: 83/255.0, blue: 155/255.0, alpha: 1.0).cgColor
        cell.backgroundCard.layer.cornerRadius = 10.0
        
        cell.checkInButton.layer.cornerRadius = 10.0

        cell.eventTitle.text = agendaEv.summary
        cell.timeLabel.text = "Time: " + agendaEv.starttime + " - " + agendaEv.endtime
        cell.monthLabel.text = agendaEv.startmonth.uppercased()
        cell.dayLabel.text = agendaEv.startday
        cell.locLabel.text = "Location: " + agendaEv.address
        
        cell.delegate = self
        cell.setEvent(event: agendaEv ?? Event.init(id: "", start_date: "", end_date: "", summary: "", description: "", status: "", sponsor: "", co_sponsors: "", location: ["":""], contact: ["":""], categories: [""], link: "", event_url: "", series_name: "", image_url: "")!)
        
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete{
            var delete_id = agendaEvents[indexPath.row].id
            agendaEvents.remove(at: indexPath.row)
            deleteObj(id: delete_id)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
    
    func deleteObj(id: String) {
        let fetchRequest: NSFetchRequest<EventID> = EventID.fetchRequest()
        
        do{
            let agendaArray = try PersistenceService.context.fetch(fetchRequest)
            for agenda in agendaArray{
                if( agenda.id == id ){
                    PersistenceService.context.delete(agenda)
                    PersistenceService.saveContext()
                }
            }
        } catch {}
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "EventInfoViewController") as? EventInfoViewController
        
        vc?.event = self.month_events[months[indexPath.section]]![indexPath.row]
        vc?.sum = agendaEvents[indexPath.row].summary
        vc?.sdl = agendaEvents[indexPath.row].startday
        vc?.sml = agendaEvents[indexPath.row].startmonth
        vc?.ll = agendaEvents[indexPath.row].address
        vc?.imageURL = agendaEvents[indexPath.row].image_url
        vc?.webEventURL = agendaEvents[indexPath.row].event_url
        vc?.tl = agendaEvents[indexPath.row].starttime + " - " + self.agendaEvents[indexPath.row].endtime
        if( agendaEvents[indexPath.row].ongoing ){
            vc?.tl = "Ongoing"
        }
        vc?.dl = agendaEvents[indexPath.row].description
        vc?.ldl = agendaEvents[indexPath.row].start_date
        if( agendaEvents[indexPath.row].ongoing ){
            vc?.ldl = agendaEvents[indexPath.row].start_date + " - " + agendaEvents[indexPath.row].end_date
        }
        vc?.sl = agendaEvents[indexPath.row].sponsor
        self.navigationController?.show(vc!, sender: true)
        //present(vc!, animated: true)
    }
    
}
