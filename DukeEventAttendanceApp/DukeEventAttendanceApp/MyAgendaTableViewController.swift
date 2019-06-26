//
//  MyAgendaTableViewController.swift
//  DukeEventAttendanceApp
//
//  Created by Luiza Wolf on 6/13/19.
//  Copyright © 2019 Duke OIT. All rights reserved.
//

import UIKit
import CoreData


class MyAgendaTableViewController: UITableViewController {
    
    var agendaEvents: [Event] = []
    
    override func viewDidLoad() {
        self.title = "My Agenda"
        super.viewDidLoad()
        self.tableView.delegate = self //maybe
        self.tableView.dataSource = self //maybe
        self.tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
                }
            }
            var index = 0
//            for global in globalagendaEvents {
//                if (agendaArray.count > 0) {
//                    if global.id == agendaArray[index].id {
//                        agendaEvents.append(global)
//                        index += 1
//                        if( index >= agendaArray.count ){
//                            break
//                        }
//                    }
//                }
//
//
//            }
            
        } catch {}
        self.tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return agendaEvents.count
    }
    
   
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AgendaTableViewCell", for: indexPath) as? AgendaTableViewCell else {
            fatalError ("the cell is not an instance of agenda table view cell")
        }
        
        // Configure the cell...
        
        let agendaEv = agendaEvents[indexPath.row]
        
//        @objc func sendtoDB(sender: UIButton) {
//            print ("yay")
//        }
//
//        cell.checkInButton.addTarget(self, action:#selector(sendtoDB(sender:)), for: .touchUpInside)
        
       
       
        cell.id = agendaEv.id
        cell.title = agendaEv.summary
        
        cell.nameLabel.text = agendaEv.summary

        cell.timeLabel.text = agendaEv.starttime + "-" + agendaEv.endtime
        cell.monthLabel.text = agendaEv.startmonth
        cell.dayLabel.text = agendaEv.startday
        cell.locationLabel.text = agendaEv.address
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
        
        vc?.event = agendaEvents[indexPath.row]
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
