//
//  EventInfoViewController.swift
//  DukeEventAttendanceApp
//
//  Created by Luiza Wolf on 6/7/19.
//  Copyright © 2019 Duke OIT. All rights reserved.
//

import UIKit

class EventInfoViewController: UIViewController {

    @IBOutlet weak var summaryLabel: UILabel!
    
    
    @IBOutlet weak var shortDayLabel: UILabel!
    @IBOutlet weak var shortMonthLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var longDateLabel: UILabel!
    @IBOutlet weak var imageLabel: UIImageView!
    @IBOutlet weak var sponsorLabel: UILabel!
    
    @IBAction func showSummary(_ sender: Any) {
       descriptionLabel.numberOfLines = 0
        
    }
    
    
    @IBOutlet weak var calIcon: UIImageView!
    @IBOutlet weak var timeIcon: UIImageView!
    @IBOutlet weak var locIcon: UIImageView!
    

    @IBOutlet weak var scrollView: UIScrollView!
    
    var sum = ""
    var sdl = ""
    var sml = ""
    var ll = ""
    var tl = ""
    var dl = ""
    var ldl = ""
    var image = UIImage()
    var imageURL = ""
    var sl = ""
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = ""
        descriptionLabel.numberOfLines = 4
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 200)
            
            //CGSizeMake(self.view.frame.width, self.view.frame.height + 100)
        
        summaryLabel.text = sum
        shortDayLabel.text = sdl
        shortMonthLabel.text = sml
        locationLabel.text = ll
        timeLabel.text = tl
        descriptionLabel.text = dl
        longDateLabel.text = ldl
        //imageLabel.image = image
        sponsorLabel.text = sl
        
        if let imageUrl = URL(string: imageURL) {
            // This is a network call and needs to be run on non-UI thread
            DispatchQueue.global().async {
                let imageData = try! Data(contentsOf: imageUrl)
                let image = UIImage(data: imageData)
                DispatchQueue.main.async {
                    self.imageLabel.image = image
                }
            }
        }
        
        imageLabel.contentMode = UIView.ContentMode.scaleAspectFill
        imageLabel.clipsToBounds = true
        
        
        
        
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
