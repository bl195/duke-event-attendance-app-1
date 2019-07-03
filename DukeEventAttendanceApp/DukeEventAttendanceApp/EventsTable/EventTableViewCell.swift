//
//  EventTableViewCell.swift
//  DukeEventAttendanceApp
//
//  Created by Luiza Wolf on 6/6/19.
//  Copyright © 2019 Duke OIT. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var backgroundCard: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
