//
//  AgendaTableViewCell.swift
//  DukeEventAttendanceApp
//
//  Created by Luiza Wolf on 6/19/19.
//  Copyright © 2019 Duke OIT. All rights reserved.
//

import UIKit

class AgendaTableViewCell: UITableViewCell {
    

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var monthLabel: UILabel!
    
    
    @IBOutlet weak var dayLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

