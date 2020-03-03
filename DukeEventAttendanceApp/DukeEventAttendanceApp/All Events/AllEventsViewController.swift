//
//  AllEventsViewController.swift
//  DukeEventAttendanceApp
//
//  Created by Luiza Wolf on 7/6/19.
//  Copyright © 2019 Duke OIT. All rights reserved.
//

import UIKit
//not sure if this is necessary, might delete, can't find where it's used
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

    }
}
