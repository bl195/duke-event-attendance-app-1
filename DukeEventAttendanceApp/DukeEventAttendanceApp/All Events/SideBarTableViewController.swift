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
    
    let datas: [Message] = [Message(for: "Date", UIImage(named: "icons8")!),  Message(for: "Topic", UIImage(named: "topics")!)]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "FILTER BY:"
        //self.navigationController?.navigationBar.titleView = "Filter By:"
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.kern: 5.0, NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 35)]

       
    }
    
    
    @objc func tapButton(){
        print("tapped")
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return datas.count
//    }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell") as! MessageCell
            
            cell.labelcell.text = datas[indexPath.row].summary
            cell.imagecell.image = datas[indexPath.row].pic
            
            return cell
        
        
        
    }
    
}
