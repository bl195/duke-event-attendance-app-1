//
//  EventInfoViewController.swift
//  DukeEventAttendanceApp
//
//  Created by Luiza Wolf on 6/7/19.
//  Copyright © 2019 Duke OIT. All rights reserved.
//

import UIKit

/**
 View controller to display more event information if the cell is tapped on from EventTableViewController
 */
class EventInfoViewController: UIViewController {

    //linking elements from storyboard
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var check_in_Button: UIButton!
    @IBOutlet weak var webLinkButton: UIButton!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var longDateLabel: UILabel!
    @IBOutlet weak var imageLabel: UIImageView!
    @IBOutlet weak var sponsorLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBAction func webLink(_ sender: Any) {
        UIApplication.shared.open(URL(string: webEventURL) ?? URL(string: backupURL)!, options: [:], completionHandler: nil)
    }
    @IBAction func onShareTapped(_ sender: Any) {
        let activityController = UIActivityViewController(activityItems: ["hello"], applicationActivities: nil)
        present(activityController, animated: true, completion: nil)
    }
    
    //initializing variables to be assigned to elements in view
    //variables are instantiated by EventTableViewController with information from cell that is tapped
    var id = ""
    var sum = ""
    var sdl = ""
    var sml = ""
    var ll = ""
    var tl = ""
    var dl = ""
    var ldl = ""
    var image = UIImage()
    var imageURL = ""
    var webEventURL = ""
    var backupURL = ""
    var sl = ""
    var event:Event = Event(id: "", start_date: "", end_date: "", summary: "", description: "", status: "", sponsor: "", co_sponsors: "", location: ["":""], contact: ["":""], categories: [""], link: "", event_url: "", series_name: "", image_url: "")!
    //TO-DO: why is this localhost?
    var base_url = "http://localhost:3000/events/"
    var isCheckInActive = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //settings for view elements
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.isHidden = false
        self.title = ""
        descriptionLabel.numberOfLines = 0
        locationLabel.text = ll
        summaryLabel.text = sum
        descriptionLabel.numberOfLines = 0
        descriptionLabel.attributedText = dl.htmlToAttributedString
        descriptionLabel.font = UIFont.systemFont(ofSize: 17.0)
        descriptionLabel.textColor = UIColor(red: 102/255, green: 102/255, blue:102/255, alpha: 1.0)
        longDateLabel.text = ldl
        imageLabel.image = image
        sponsorLabel.text = sl
        timeLabel.text = tl
        
        //network call to get image
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
        
        webLinkButton.isEnabled = true
        webLinkButton.tintColor = UIColor(red: 1/255, green: 33/255, blue:105/255, alpha: 1.0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.isHidden = false
    }
    
    //TO-DO: this isn't actually hit from anywhere
    /**
     Sends POST request to API to check in the attendee for a specific event
     - parameters:
     - URLString: url that POST request is sent to
     - dukecal_id: duke calendar ID of a specific event
     - duid: unique ID of attendee
     */
    func hitAPI(_for URLString:String, dukecal_id: String, duid: String) {
        var actual_id = dukecal_id.replacingOccurrences(of: "@", with: "-")
        actual_id = actual_id.replacingOccurrences(of: ".", with: "-")
        actual_id = actual_id.lowercased()
        base_url = base_url + actual_id + "/attendees/addAttendee"
        print(base_url)
        //TO-DO: base_url actually isn't used
        
        guard let url = URL(string: URLString) else {return}
        
        var request : URLRequest = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let params = ["duid": duid]
        
        let jsonData = try! JSONSerialization.data(withJSONObject: params, options: [])
        request.httpBody = jsonData
        print("jsonData: ", String(data: request.httpBody!, encoding: .utf8) ?? "no body data")
        
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            if let responseData = responseData {
                do {
                    let json = try JSONSerialization.jsonObject(with: responseData, options: [])
                    print(json)
                } catch {
                    print(responseError)
                }
            }
        }
        task.resume()
        
    }
    
    /**
     When the checkInButton is tapped,
     */
    //TO-DO: needs to be implemented
    @IBAction func checkInButton(_ sender: Any) {
        //hitAPI(_for: base_url, dukecal_id: id, duid: "6033006990222254")
        print(self.event.id)
        Items.sharedInstance.eventActive(eventid: self.event.id, nav: self.navigationController!){ active, error in
            if( active ){
                print(true)
                self.isCheckInActive = true
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "checkInOption") as? CheckInOptionViewController
                vc?.eventLoc = self.ll
                vc?.event = self.event
                self.navigationController?.pushViewController(vc!, animated: true)
                
            }
            else {
                print(false)
                self.isCheckInActive = false
                self.check_in_Button.backgroundColor = UIColor.gray
            }
        }
        
        
    }
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
