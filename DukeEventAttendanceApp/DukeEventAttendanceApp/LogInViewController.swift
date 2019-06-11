//
//  LogInViewController.swift
//  DukeEventAttendanceApp
//
//  Created by Jessica Su on 6/9/19.
//  Copyright © 2019 Duke OIT. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {

    @IBOutlet weak var hostButton: UIButton!
    @IBOutlet weak var attendeeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginLayout()

    }
    private func loginLayout() {
        //topcontainer for the HOST BUTTON
        let topContainer = UIView()
        view.addSubview(topContainer) //adding container to main view
        topContainer.translatesAutoresizingMaskIntoConstraints = false //enable auto layout
        topContainer.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        topContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topContainer.addSubview(hostButton) //adding host button to top container
        hostButton.translatesAutoresizingMaskIntoConstraints = false
        hostButton.centerXAnchor.constraint(equalTo:topContainer.centerXAnchor).isActive = true
        //making the host button appear just above the bottom of the top container
        hostButton.bottomAnchor.constraint(equalTo:topContainer.bottomAnchor, constant: -20).isActive = true
        hostButton.widthAnchor.constraint(equalToConstant: 156).isActive = true
        hostButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
        //making the top container fill TOP HALF THE SCREEN
        topContainer.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        
        //bottom container for ATTENDEE BUTTON
        let bottomContainer = UIView()
        view.addSubview(bottomContainer)
        bottomContainer.translatesAutoresizingMaskIntoConstraints = false
        bottomContainer.topAnchor.constraint(equalTo:topContainer.bottomAnchor).isActive = true
        bottomContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        bottomContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        view.addSubview(attendeeButton) //adding attendee button to the bottom container
        attendeeButton.translatesAutoresizingMaskIntoConstraints = false
        attendeeButton.centerXAnchor.constraint(equalTo:bottomContainer.centerXAnchor).isActive = true
        //making the attendee button appear just below the top of the bottom container
        attendeeButton.topAnchor.constraint(equalTo:bottomContainer.topAnchor, constant: 20).isActive = true
        attendeeButton.widthAnchor.constraint(equalToConstant: 156).isActive = true
        attendeeButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
        //making sure the bottom container fills the BOTTOM HALF of the screen
        bottomContainer.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
