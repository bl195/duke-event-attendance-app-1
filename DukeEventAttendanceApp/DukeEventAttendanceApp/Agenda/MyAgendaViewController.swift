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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
//        attendingButton.isSelected = true
//        hostingButton.isSelected = false
        self.navigationController?.isNavigationBarHidden = true
        
        defaultBold()
        
        pushController(contName: "MyAgendaTableViewController")

    }
    
    func pushController( contName:String ){
        let controller = storyboard!.instantiateViewController(withIdentifier: contName)
        addChild(controller)
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(controller.view)
        //print (controller.view.frame.height)
        
        scrollView.contentSize = CGSize(width: containerView.frame.width, height: controller.view.frame.height)
        print (scrollView.frame.height)
        print (scrollView.contentSize.height)
        controller.didMove(toParent: self)

    }

    @IBAction func hostingAction(_ sender: Any) {
        pushController(contName: "HostTableViewController")
        toggledBold()
    }
    
    @IBAction func attendingAction(_ sender: Any) {
        pushController(contName: "MyAgendaTableViewController")
        defaultBold()
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
