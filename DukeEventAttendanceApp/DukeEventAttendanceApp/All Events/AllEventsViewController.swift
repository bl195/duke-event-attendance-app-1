//
//  AllEventsViewController.swift
//  DukeEventAttendanceApp
//
//  Created by Luiza Wolf on 7/6/19.
//  Copyright © 2019 Duke OIT. All rights reserved.
//

import UIKit

class AllEventsViewController: UIViewController {
    @IBOutlet weak var filterButton: UIButton!
    
    @IBOutlet weak var calendarButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true

        var image = UIImage(named: "menu")?.withRenderingMode(.alwaysTemplate)
        filterButton.setImage(image, for: .normal)
        filterButton.tintColor = UIColor.white
       
        image = UIImage(named: "calendar-icon")?.withRenderingMode(.alwaysTemplate)
        calendarButton.setImage(image, for: .normal)
        calendarButton.tintColor = UIColor.white

        // Do any additional setup after loading the view.
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
