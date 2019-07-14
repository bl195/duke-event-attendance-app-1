//
//  MenuViewController.swift
//  DukeEventAttendanceApp
//
//  Created by Luiza Wolf on 6/10/19.
//  Copyright © 2019 Duke OIT. All rights reserved.
//

import UIKit

class MenuViewController: UITableViewController {
    
    var menuFilterSelected: Bool = false
    var didTapMenuType: ((String) -> Void)?
    var filtername:String = ""
    var thisDateCode = ""

    var menuArray = ["Arts", "Athletics/Recreation", "Global Duke", "Civic Engagement/Social Action", "Diversity/Inclusion", "Energy", "Engineering", "Ethics", "Health/Wellness", "Humanities", "Natural Sciences", "Politics", "Religious/Spiritual", "Research", "Social Sciences", "Sustainability", "Teaching & Classroom Learning", "Technology", "University Events"]
    
    override func viewDidLoad() {
        self.title = "Topic".uppercased()
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.kern: 5.0, NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 35)]
        self.automaticallyAdjustsScrollViewInsets = false
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as? MenuTableViewCell else {
            fatalError("the cell is not an instance of the menu table view cell")
        }
        cell.topicLabel.text = menuArray[indexPath.row]
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuArray.count
    }
    
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewcontroller = storyboard?.instantiateViewController(withIdentifier: "EventTableViewController") as? EventTableViewController
        viewcontroller?.title = menuArray[indexPath.row].uppercased()
        viewcontroller?.filtername = menuArray[indexPath.row]
        viewcontroller?.encodedate = thisDateCode
        self.navigationController?.pushViewController(viewcontroller!, animated:true)
        
    }
 
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
