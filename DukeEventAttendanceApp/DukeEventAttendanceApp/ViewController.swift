//
//  ViewController.swift
//  DukeEventAttendanceApp
//
//  Created by Luiza Wolf on 6/6/19.
//  Copyright © 2019 Duke OIT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var logInButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.photoImageView.image = UIImage(named: "DukeCheck")
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        photoImageView.contentMode = .scaleAspectFit
        setUpLayout()
    }
    
    private func setUpLayout() {
        let topImageContainerView = UIView()
        //topImageContainerView.backgroundColor = .blue
        view.addSubview(topImageContainerView)
        //enable autolayout
        topImageContainerView.translatesAutoresizingMaskIntoConstraints = false
        topImageContainerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        //better to use trailing and leading anchor rather than left and right anchor
        topImageContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topImageContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        topImageContainerView.addSubview(photoImageView)
        photoImageView.centerXAnchor.constraint(equalTo: topImageContainerView.centerXAnchor).isActive = true
        photoImageView.centerYAnchor.constraint(equalTo: topImageContainerView.centerYAnchor).isActive = true
        photoImageView.heightAnchor.constraint(equalTo: topImageContainerView.heightAnchor, multiplier: 0.5).isActive = true
        
        //making sure the top container is 3/4 the size of the entire screen
        topImageContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.75).isActive = true
        
        logInButton.translatesAutoresizingMaskIntoConstraints = false
        logInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logInButton.widthAnchor.constraint(equalToConstant: 156).isActive = true
        logInButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
        logInButton.topAnchor.constraint(equalTo: topImageContainerView.bottomAnchor).isActive = true
       
        
        
        
        
        
        
        
        
        
    }
    


}

