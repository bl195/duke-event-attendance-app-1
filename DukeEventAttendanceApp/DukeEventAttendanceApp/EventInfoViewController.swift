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
    
    @IBOutlet weak var extendButton: UIButton!
    var tapCount = 0
    @IBAction func extendText(_ sender: Any) {
        if( tapCount%2 == 0){
            descriptionLabel.numberOfLines = 0
            tapCount += 1
        }
        else{
            descriptionLabel.numberOfLines = 4
            tapCount += 1
        }
    }
    
    @IBOutlet weak var shortDayLabel: UILabel!
    @IBOutlet weak var shortMonthLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var longDateLabel: UILabel!
    @IBOutlet weak var imageLabel: UIImageView!
    @IBOutlet weak var sponsorLabel: UILabel!
    

    
    
    
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
    var event:Event = Event(id: "", start_date: "", end_date: "", summary: "", description: "", status: "", sponsor: "", co_sponsors: "", location: ["":""], contact: ["":""], categories: [""], link: "", event_url: "", series_name: "", image_url: "")!
    
    //var agendaArray = [Event]()
    //var agendavc = MyAgendaTableViewController().myAgendaArray
    
    @IBAction func addToAgenda(_ sender: Any) {
        
        //EventTableViewController().agendavc.append(event)
        //agendaArray.append(event)
        //agendavc.append(event)
//        let agendavc = storyboard?.instantiateViewController(withIdentifier: "MyAgendaTableViewController") as? MyAgendaTableViewController
        //MyAgendaTableViewController().addToArray(event: event)
        //print("going to add " + event.summary)
        //event.addToAgenda()
        let agendavc = storyboard?.instantiateViewController(withIdentifier: "MyAgendaTableViewController") as? MyAgendaTableViewController
        agendavc?.addEventToFile(eventID: event.id)
        agendavc?.readTextFile()
//        print(EventTableViewController().agendavc.count)
//        print(agendaArray.count)
//        print(agendavc.count)
//        agendavc?.addToArray(event: event)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = ""
        //descriptionLabel.numberOfLines = 0
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 500)
            //CGSizeMake(self.view.frame.width, self.view.frame.height + 100)
        
        summaryLabel.text = sum
        shortDayLabel.text = sdl
        shortMonthLabel.text = sml
        locationLabel.text = ll
        timeLabel.text = tl
       descriptionLabel.numberOfLines = 4
        descriptionLabel.attributedText = dl.htmlToAttributedString
        descriptionLabel.font = UIFont.systemFont(ofSize: 17.0)
        descriptionLabel.textColor = UIColor(red: 102/255, green: 102/255, blue:102/255, alpha: 1.0)
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

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
