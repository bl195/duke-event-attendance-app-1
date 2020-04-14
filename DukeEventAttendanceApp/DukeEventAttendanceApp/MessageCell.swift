//
//  MessageCell.swift
//  DukeEventAttendanceApp
//
//  Created by Brian Li on 7/17/19.
//  Copyright © 2019 Duke OIT. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var imagecell: UIImageView!
    @IBOutlet weak var labelcell: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
