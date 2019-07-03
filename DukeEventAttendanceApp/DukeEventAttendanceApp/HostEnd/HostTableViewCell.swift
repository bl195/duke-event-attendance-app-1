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
    
    @IBOutlet weak var backgroundCard: UIView!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    
    @IBOutlet weak var allowCheckInButton: UIButton!
    @IBOutlet weak var locLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var allowCheckInAction : (() -> ())?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.allowCheckInButton.addTarget(self, action: #selector(checkInTapped(_:)), for: .touchUpInside)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func checkInTapped(_ sender: Any) {
        allowCheckInAction?()
    }
}
