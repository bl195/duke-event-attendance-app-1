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
        cell.nameLabel.text = agendaEv.summary
//        if let imageUrl = URL(string: agendaEv.image_url) {
//            DispatchQueue.global().async {
//                let imageData = try! Data(contentsOf: imageUrl)
//                let image = UIImage(data:imageData)
//                DispatchQueue.main.async {
//                    cell.photoImageView.image = image
//                }
//            }
//        }
//
//        cell.photoImageView.contentMode = UIView.ContentMode.scaleAspectFill
//        cell.photoImageView.layer.cornerRadius = 10.0
//        cell.photoImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
//        cell.photoImageView.clipsToBounds = true
//
//        cell.backgroundImage.layer.cornerRadius = 10.0
//        cell.backgroundImage.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
//        cell.backgroundImage.clipsToBounds = true
//
//        cell.dateLabel.text = agendaEv.start_date
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
    
}
