//
//  HostTableViewCell.swift
//  DukeEventAttendanceApp
//
//  Created by Luiza Wolf on 7/3/19.
//  Copyright © 2019 Duke OIT. All rights reserved.
//

import UIKit

protocol HostTableViewCellDelegate {
    func didTapAllowCheckIn(eventid:String)
}

class HostTableViewCell: UITableViewCell {
    
    var event: Event!
    var delegate: HostTableViewCellDelegate?
    
    @IBOutlet weak var eventTitle: UILabel!
    
    @IBOutlet weak var backgroundCard: UIView!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    
    @IBOutlet weak var allowCheckInButton: UIButton!
    @IBOutlet weak var locLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBAction func allowCheckInTapped(_ sender: Any) {
        delegate?.didTapAllowCheckIn(eventid: event.id) //call didTapAllowCheckIn from HostTableViewController
    }
    
    //Called by HostTableViewController to store event of current row
    func setEvent(event: Event){
        self.event = event 
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
