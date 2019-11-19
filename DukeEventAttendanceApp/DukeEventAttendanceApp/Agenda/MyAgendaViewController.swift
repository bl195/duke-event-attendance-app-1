//
//  MyAgendaViewController.swift
//  DukeEventAttendanceApp
//
//  Created by Luiza Wolf on 7/2/19.
//  Copyright © 2019 Duke OIT. All rights reserved.
//

import UIKit

class MyAgendaViewController: UIViewController{

    @IBOutlet weak var hostingButton: UIButton!

    @IBOutlet weak var attendingButton: UIButton!
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var currentController = UIViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
//        attendingButton.isSelected = true
//        hostingButton.isSelected = false
        //self.navigationController?.isNavigationBarHidden = false
        
        defaultBold()
        
        pushController(contName: "MyAgendaTableViewController")
    }
    
    func pushController( contName:String ) {
        removeChildController()
        currentController = storyboard!.instantiateViewController(withIdentifier: contName)
        addChild(currentController)
        currentController.view.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(currentController.view)
        //print (controller.view.frame.height)
        
        scrollView.contentSize = CGSize(width: containerView.frame.width, height: currentController.view.frame.height)
        print (scrollView.frame.height)
        print (scrollView.contentSize.height)
        currentController.didMove(toParent: self)
    }
    
    func removeChildController() {
        currentController.willMove(toParent: currentController.parent)
        currentController.view.removeFromSuperview()
        currentController.removeFromParent()
    }

    @IBAction func hostingAction(_ sender: Any) {
        if !(currentController is HostTableViewController) {
            pushController(contName: "HostTableViewController")
            toggledBold()
        }
        
    }
    
    @IBAction func attendingAction(_ sender: Any) {
        if !(currentController is MyAgendaTableViewController) {
            pushController(contName: "MyAgendaTableViewController")
            defaultBold()
        }
    }
    
    func defaultBold(){
        var hostingTitle = NSAttributedString(string: "HOSTING", attributes: [NSAttributedString.Key.kern: 5.0, NSAttributedString.Key.font: UIFont(name: "Helvetica-Light", size: 18)!])
        hostingButton.titleLabel?.attributedText = hostingTitle
        
        var attendingTitle = NSAttributedString(string: "ATTENDING", attributes: [NSAttributedString.Key.kern: 5.0, NSAttributedString.Key.font: UIFont(name: "Helvetica-Bold", size: 18)!])
        attendingButton.titleLabel?.attributedText = attendingTitle
    }
    
    func toggledBold(){
        var hostingTitle = NSAttributedString(string: "HOSTING", attributes: [NSAttributedString.Key.kern: 5.0, NSAttributedString.Key.font: UIFont(name: "Helvetica-Bold", size: 18)!])
        hostingButton.titleLabel?.attributedText = hostingTitle
        
        var attendingTitle = NSAttributedString(string: "ATTENDING", attributes: [NSAttributedString.Key.kern: 5.0, NSAttributedString.Key.font: UIFont(name: "Helvetica-Light", size: 18)!])
        attendingButton.titleLabel?.attributedText = attendingTitle
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
