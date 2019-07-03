//
//  HostTableViewCell.swift
//  DukeEventAttendanceApp
//
//  Created by Luiza Wolf on 7/3/19.
//  Copyright © 2019 Duke OIT. All rights reserved.
//

import UIKit

class HostTableViewCell: UITableViewCell {

    @IBOutlet weak var eventTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
