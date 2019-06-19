//
//  AgendaTableViewController.swift
//  DukeEventAttendanceApp
//
//  Created by Jessica Su on 6/16/19.
//  Copyright © 2019 Duke OIT. All rights reserved.
//

import UIKit
import CoreData

class AgendaTableViewController: UITableViewController {

    //var stateController: stateController?
    //var secondTab = self.tab
    
    var agendaEvents: [Event] = [] //EventTableViewController().agendaEvents
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(Items.sharedInstance.agendaEvents)
//       let tbc = self.tabBarController as! eventTabBarController
//        agendaEvents = tbc.agendaEvents
//        for agenda in agendaEvents {
//            print (agenda.summary)
//        }
        agendaEvents = Items.sharedInstance.agendaEvents
        
        let fetchRequest: NSFetchRequest<EventID> = EventID.fetchRequest()
        
        do {
            deleteAllData("EventID")
            
            var agendaArray1 = try PersistenceService.context.fetch(fetchRequest)
            //agendaArray1.removeAll()
            for event in agendaArray1{
                print(event)
            }
            for event in Items.sharedInstance.eventArray{
                var e = EventID(context: PersistenceService.context)
                e.id = event.id
                for idobj in agendaArray1{
                    var id = idobj.id
                    if( (id?.isEqual(e.id))! ){
                        Items.sharedInstance.agendaEvents.append(event)
                    }
                }
            }
            //self.agendaEvents = agendaEvents
            self.tableView.reloadData()
        } catch {}
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.reloadData()
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func deleteAllData(_ entity:String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "EventID")
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try PersistenceService.context.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
                PersistenceService.context.delete(objectData)
                PersistenceService.saveContext()
            }
        } catch let error {
            print("Delete all data in \(entity) error :", error)
        }
    }
    
//    func deleteAllData(entity: String)
//    {
//        let ReqVar = NSFetchRequest(entityName: entity)
//        let DelAllReqVar = NSBatchDeleteRequest(fetchRequest: ReqVar)
//        do { try ContxtVar.executeRequest(DelAllReqVar) }
//        catch { print(error) }
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        agendaEvents = Items.sharedInstance.agendaEvents
        let fetchRequest: NSFetchRequest<EventID> = EventID.fetchRequest()
        
        do {
            let agendaArray = try PersistenceService.context.fetch(fetchRequest)
//            for agenda in agendaArray {
//                //print(agenda.id)
//            }
            //self.agendaEvents = agendaEvents
            //self.tableView.reloadData()
        } catch {}
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

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

        let agendaEv = Items.sharedInstance.agendaEvents[indexPath.row]
        cell.nameLabel.text = agendaEv.summary
        if let imageUrl = URL(string: agendaEv.image_url) {
            DispatchQueue.global().async {
                let imageData = try! Data(contentsOf: imageUrl)
                let image = UIImage(data:imageData)
                DispatchQueue.main.async {
                    cell.photoImageView.image = image 
                }
            }
        }
        
        cell.photoImageView.contentMode = UIView.ContentMode.scaleAspectFill
        cell.photoImageView.layer.cornerRadius = 10.0
        cell.photoImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        cell.photoImageView.clipsToBounds = true
        
        cell.backgroundImage.layer.cornerRadius = 10.0
        cell.backgroundImage.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        cell.backgroundImage.clipsToBounds = true
        
        cell.dateLabel.text = agendaEv.start_date
        cell.locationLabel.text = agendaEv.address
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
