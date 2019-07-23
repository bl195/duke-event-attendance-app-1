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
    
    var menuFilterSelected: Bool = false
    var didTapMenuType: ((String) -> Void)?
    var filtername:String = ""
    var thisDateCode = ""
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
    
    let datas: [Message] = [Message(for: "Calendar", UIImage(named: "icons8")!),  Message(for: "Topic Filter", UIImage(named: "topics")!)]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.kern: 5.0, NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 35)]
        
//         tableViewData = [cellData(opened: false, sectionData: ["Arts", "Athletics/Recreation", "Global Duke", "Civic Engagement/Social Action", "Diversity/Inclusion", "Energy", "Engineering", "Ethics", "Health/Wellness", "Humanities", "Natural Sciences", "Politics", "Religious/Spiritual", "Research", "Social Sciences", "Sustainability", "Teaching & Classroom Learning", "Technology", "University Events"])]
        
//        oAuthService = OAuthService.shared
       
    }
    
    
    @objc func tapButton(){
        print("tapped")
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
//        if tableViewData[section].opened == true{
//            return tableViewData[section].sectionData.count + datas.count
//        }
//        else{
        return datas.count
//    }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        if indexPath.row == 1 || indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell") as! MessageCell
            
            cell.labelcell.text = datas[indexPath.row].summary
            cell.imagecell.image = datas[indexPath.row].pic
            
            return cell
        
            
//        else{
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell") else {return UITableViewCell()}
//            cell.textLabel?.text = tableViewData[indexPath.section].sectionData[indexPath.row-3]
//            return cell
//        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(indexPath.row == 1){
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController
                        self.navigationController?.pushViewController(vc!, animated: true)
            
//            if tableViewData[indexPath.section].opened == true{
//                tableViewData[indexPath.section].opened = false
//                let sections = IndexSet.init(integer: indexPath.section)
//                tableView.reloadSections(sections, with: .none)
//            }else{
//                tableViewData[indexPath.section].opened = true
//                let sections = IndexSet.init(integer: indexPath.section)
//                tableView.reloadSections(sections, with: .none)
//            }
        }
        
        if (indexPath.row == 0){
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "CalendarViewController") as? CalendarViewController
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        
//        if(indexPath.row == 0){
//
//            let alert = UIAlertController(title: "Logout", message: "Do you want to Log out?", preferredStyle: .alert)
//            let subButton = UIAlertAction(title: "Yes", style: .default, handler: { (action) -> Void in
//                self.oAuthService?.logout()
//                print (self.oAuthService?.isAuthenticated())
//                let vc = self.storyboard?.instantiateViewController(withIdentifier: "mainNav") as? UINavigationController
//                self.navigationController?.present(vc!, animated: true)
//
//                print("logged out")
//
//            })
//            let cancelButton = UIAlertAction(title: "No", style: .cancel, handler: nil)
//            alert.addAction(subButton)
//            alert.addAction(cancelButton)
//            self.present(alert, animated: true, completion: nil)
////            if(subButton.isEnabled == true){
////                oAuthService?.logout()
////                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as? UIViewController
////                self.navigationController?.present(vc!, animated: true)
////
////                print("logged out")
////            }
//        }
//        if(indexPath.row > 2){
//            let viewcontroller = storyboard?.instantiateViewController(withIdentifier: "EventTableViewController") as? EventTableViewController
//            viewcontroller?.title = menuArray[indexPath.row-3].uppercased()
//            viewcontroller?.filtername = menuArray[indexPath.row-3]
//            viewcontroller?.encodedate = thisDateCode
//            self.navigationController?.pushViewController(viewcontroller!, animated:true)
//        }
        
    }
    
}
