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
    
    //Initialize Image and Label for Side Bar
    class Message{
        
        let summary: String
        let pic: UIImage
        
        init(for summ: String, _ icon: UIImage){
            self.summary = summ
            self.pic = icon
        }
    }
    
    //Create data for image and topic
    let datas: [Message] = [Message(for: "Date", UIImage(named: "icons8")!),  Message(for: "Topic", UIImage(named: "topics")!)]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "FILTER BY:"
        //self.navigationController?.navigationBar.titleView = "Filter By:"
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.kern: 5.0, NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 35)]
       
    }
    
    //test if button is tapped and returns String
    @objc func tapButton(){
        print("tapped")
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    //returns number of rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    //set text and image for tableview
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell") as! MessageCell
            
            cell.labelcell.text = datas[indexPath.row].summary
            cell.imagecell.image = datas[indexPath.row].pic
            
            return cell
        
        
    }
    
    //
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(indexPath.row == 1){
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController
                        self.navigationController?.pushViewController(vc!, animated: true)
            
        }
        if (indexPath.row == 0){
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "CalendarViewController") as? CalendarViewController
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        
    }
    
}
