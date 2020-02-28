//
//  SideBarTableViewController.swift
//  DukeEventAttendanceApp
//
//  Created by Brian Li on 7/17/19.
//  Copyright © 2019 Duke OIT. All rights reserved.
//

import UIKit

class SideBarTableViewController: UITableViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //switch
        let my_switch = UISwitch(frame: .zero)
        my_switch.isOn = switchOn
        my_switch.addTarget(self, action: #selector(switchToggled(_:)), for: .valueChanged)
        let switch_display = UIBarButtonItem(customView: my_switch)
        navigationItem.rightBarButtonItems = [cal, switch_display]
        
        
        //settings bar
        let settings_display = UIBarButtonItem(image: UIImage(named: "icons8-settings-24"), style: .done, target: self, action: #selector(tapButton))
        
        navigationItem.leftBarButtonItems = [topicfilter, settings_display]

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
    
    
        func numberOfSections(in tableView: UITableView) -> Int {

        // #warning Incomplete implementation, return the number of sections
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
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
