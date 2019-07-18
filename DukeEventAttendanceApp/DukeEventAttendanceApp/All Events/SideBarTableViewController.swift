//
//  SideBarTableViewController.swift
//  DukeEventAttendanceApp
//
//  Created by Brian Li on 7/17/19.
//  Copyright © 2019 Duke OIT. All rights reserved.
//

import UIKit
import Apollo

struct cellData {
    var opened = Bool()
    var sectionData = [String]()
}


class SideBarTableViewController: UITableViewController {
    
    var oAuthService: OAuthService?
    var tableViewData = [cellData]()
    
    class Message{
        
        let summary: String
        let pic: UIImage
        
        init(for summ: String, _ icon: UIImage){
            self.summary = summ
            self.pic = icon
        }
    }
    
    let datas: [Message] = [Message(for: "Logout", UIImage(named: "logout")!), Message(for: "Calendar", UIImage(named: "calendar-icon")!),  Message(for: "Topic Filter", UIImage(named: "topics")!)]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         tableViewData = [cellData(opened: false, sectionData: ["cell1","cell2","cell3"])]
        
        oAuthService = OAuthService.shared
       
    }
    
    
    @objc func tapButton(){
        print("tapped")
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return tableViewData.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if tableViewData[section].opened == true{
            return tableViewData[section].sectionData.count
        }
        else{
        return datas.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row >= 2{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell")else {return UITableViewCell()}
            cell.textLabel?.text = tableViewData[indexPath.section].sectionData[indexPath.row]
            return cell
        }
        else{
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell") as! MessageCell
        
        cell.labelcell.text = datas[indexPath.row].summary
        cell.imagecell.image = datas[indexPath.row].pic
        
        return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 1){
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "CalendarViewController") as? CalendarViewController
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        
        if(indexPath.row == 0){
            
            let alert = UIAlertController(title: "Logout", message: "Do you want to Log out?", preferredStyle: .alert)
            let subButton = UIAlertAction(title: "Yes", style: .default, handler: { (action) -> Void in
                self.oAuthService?.logout()
                print (self.oAuthService?.isAuthenticated())
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "mainNav") as? UINavigationController
                self.navigationController?.present(vc!, animated: true)
                
                print("logged out")
                
            })
            let cancelButton = UIAlertAction(title: "No", style: .cancel, handler: nil)
            alert.addAction(subButton)
            alert.addAction(cancelButton)
            self.present(alert, animated: true, completion: nil)
//            if(subButton.isEnabled == true){
//                oAuthService?.logout()
//                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as? UIViewController
//                self.navigationController?.present(vc!, animated: true)
//
//                print("logged out")
//            }
        }
        
        if(indexPath.row == 2){
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController
//            self.navigationController?.pushViewController(vc!, animated: true)
            
            if tableViewData[indexPath.section].opened == true{
                tableViewData[indexPath.section].opened = false
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none)
            }else{
                tableViewData[indexPath.section].opened = true
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none)
            }
        }
        
    }

}
