//
//  EventTableViewCell.swift
//  PracticeJSONCalendar
//
//  Created by Luiza Wolf on 6/5/19.
//  Copyright © 2019 Luiza Wolf. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    //properties
    @IBOutlet weak var outle: UIButton!
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
