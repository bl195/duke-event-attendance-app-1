//
//  CustomHeader.swift
//  DukeEventAttendanceApp
//
//  Created by Luiza Wolf on 7/15/19.
//  Copyright © 2019 Duke OIT. All rights reserved.
//

import UIKit

/**
 Header to be used in CurrentAttendeesViewController
 */
class CustomHeader: UITableViewHeaderFooterView {
    let title = UILabel()
    let checkintime = UILabel()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureContents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureContents() {
        title.translatesAutoresizingMaskIntoConstraints = false
        checkintime.translatesAutoresizingMaskIntoConstraints = false
        title.numberOfLines = 2
        contentView.backgroundColor = UIColor(red:0.00, green:0.13, blue:0.41, alpha:1.0)
        contentView.addSubview(title)
        contentView.addSubview(checkintime)
        NSLayoutConstraint.activate([
            title.widthAnchor.constraint(equalToConstant: 370),
            title.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            checkintime.heightAnchor.constraint(equalToConstant: 30),
            checkintime.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            checkintime.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 80)
            ])
    }
}
