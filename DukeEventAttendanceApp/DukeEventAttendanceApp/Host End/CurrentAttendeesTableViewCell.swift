//
//  CurrentAttendeesTableViewCell.swift
//  DukeEventAttendanceApp
//
//  Created by Luiza Wolf on 7/2/19.
//  Copyright © 2019 Duke OIT. All rights reserved.
//
import UIKit

/*
    This class is responsible for representing a table view cell
    that will display a list of the current attendees.
 */
class CurrentAttendeesTableViewCell: UITableViewCell {

    @IBOutlet weak var dukeCardNumber: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var checkInTime: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
