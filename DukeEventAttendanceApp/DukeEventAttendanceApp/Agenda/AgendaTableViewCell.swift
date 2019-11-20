//
//  AgendaTableViewCell.swift
//  DukeEventAttendanceApp
//
//  Created by Luiza Wolf on 6/19/19.
//  Copyright © 2019 Duke OIT. All rights reserved.
//

import UIKit

protocol AgendaTableViewCellDelegate {
    func didTapCheckIn(event:Event)
}

class AgendaTableViewCell: UITableViewCell {
    
    var event: Event!
    var delegate: AgendaTableViewCellDelegate?
    
    var active = false

    @IBOutlet weak var monthLabel: UILabel!
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var locLabel: UILabel!
    
    @IBOutlet weak var checkInButton: UIButton!
    @IBOutlet weak var backgroundCard: UIView!
    
    @IBAction func checkInTapped(_ sender: Any) {
        delegate?.didTapCheckIn(event: self.event)
        //eventTitle.textAlignment = NSTextAlignment.natural
    }
    
    func setEvent(event: Event){
        self.event = event
        print(event.summary)
        print(self.active)
        if (self.active) {
            self.checkInButton.setTitle("C H E C K - I N", for: .normal)
        }
        if(!self.active){
            self.checkInButton.isEnabled = false
            self.checkInButton.setTitle("C H E C K - I N  N O T  A V A I L A B L E", for: .disabled)
            self.checkInButton.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    

}

