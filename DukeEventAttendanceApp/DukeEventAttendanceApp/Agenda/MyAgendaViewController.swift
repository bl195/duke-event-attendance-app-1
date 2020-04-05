//
//  MyAgendaViewController.swift
//  DukeEventAttendanceApp
//
//  Created by Luiza Wolf on 7/2/19.
//  Copyright © 2019 Duke OIT. All rights reserved.
//

import UIKit

/**
 View controller to contain and switch between the hosting agenda and the attending agenda
 */
class MyAgendaViewController: UIViewController{

    @IBOutlet weak var hostingButton: UIButton!
    @IBOutlet weak var attendingButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    var currentController = UIViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        defaultBold()
        pushController(contName: "MyAgendaTableViewController")
    }
    
    /**
     Switches between the host agenda view and the attendee agenda view
     - parameters:
        - contName: name of controller to switch to; should be "MyAgendaTableViewController" for attendee or "HostTableViewController" for host
     */
    func pushController( contName:String ) {
        removeChildController()
        currentController = storyboard!.instantiateViewController(withIdentifier: contName)
        addChild(currentController)
        currentController.view.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(currentController.view)
        scrollView.contentSize = CGSize(width: containerView.frame.width, height: currentController.view.frame.height)
        
        #if DEBUG
            print (scrollView.frame.height)
            print (scrollView.contentSize.height)
        #endif
        
        currentController.didMove(toParent: self)
    }
    
    /**
     Helper function for pushController to remove current view
    */
    func removeChildController() {
        currentController.willMove(toParent: currentController.parent)
        currentController.view.removeFromSuperview()
        currentController.removeFromParent()
    }

    /**
     When "HOSTING" is tapped, switch to the host agenda view and make "HOSTING" bold to indicate that user is on that view
    */
    @IBAction func hostingAction(_ sender: Any) {
        if !(currentController is HostTableViewController) {
            pushController(contName: "HostTableViewController")
            toggledBold()
        }
        
    }
    
    /**
     When "ATTENDING" is tapped, switch to the host agenda view and make "ATTENDING" bold to indicate that user is on that view
     */
    @IBAction func attendingAction(_ sender: Any) {
        if !(currentController is MyAgendaTableViewController) {
            pushController(contName: "MyAgendaTableViewController")
            defaultBold()
        }
    }
    
    /**
     Font formatting for when agenda tab is first opened
     */
    func defaultBold(){
        let hostingTitle = NSAttributedString(string: "HOSTING", attributes: [NSAttributedString.Key.kern: 5.0, NSAttributedString.Key.font: UIFont(name: "Helvetica-Light", size: 18)!])
        hostingButton.titleLabel?.attributedText = hostingTitle
        
        let attendingTitle = NSAttributedString(string: "ATTENDING", attributes: [NSAttributedString.Key.kern: 5.0, NSAttributedString.Key.font: UIFont(name: "Helvetica-Bold", size: 18)!])
        attendingButton.titleLabel?.attributedText = attendingTitle
    }
    
    /**
     Font formatting for when user switches between hosting and attending tab
     */
    func toggledBold(){
        let hostingTitle = NSAttributedString(string: "HOSTING", attributes: [NSAttributedString.Key.kern: 5.0, NSAttributedString.Key.font: UIFont(name: "Helvetica-Bold", size: 18)!])
        hostingButton.titleLabel?.attributedText = hostingTitle
        
        let attendingTitle = NSAttributedString(string: "ATTENDING", attributes: [NSAttributedString.Key.kern: 5.0, NSAttributedString.Key.font: UIFont(name: "Helvetica-Light", size: 18)!])
        attendingButton.titleLabel?.attributedText = attendingTitle
    }
}
