//
//  CustomHeader.swift
//  DukeEventAttendanceApp
//
//  Created by Luiza Wolf on 7/5/19.
//  Copyright © 2019 Duke OIT. All rights reserved.
//

import UIKit

class CustomHeader: UITableViewHeaderFooterView {
    
    let month = UILabel()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureContents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureContents(){
        month.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(month)
        
        NSLayoutConstraint.activate([
            month.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            month.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            ])
        month.font = UIFont(name: "Helvetica", size: 16)
        month.text?.uppercased()
        
    }

}
