//
//  AgendaTableViewCell.swift
//  DukeEventAttendanceApp
//
//  Created by Luiza Wolf on 6/19/19.
//  Copyright © 2019 Duke OIT. All rights reserved.
//

import UIKit

class AgendaTableViewCell: UITableViewCell {
    

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var monthLabel: UILabel!
    
    
    @IBOutlet weak var dayLabel: UILabel!
    
    
    @IBOutlet weak var checkInButton: UIButton!
    var id = ""
    var title = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    @IBAction func sendToDB(_ sender: Any) {
        //hitAPI(_for: "http://localhost:3000/createArticleMobile", title: title, text: id)
    }
    
    func hitAPI(_for URLString:String, title: String, text: String) {
        
        guard let url = URL(string: URLString) else {return}
        
        var request : URLRequest = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let params = ["title": title, "text": text]
        
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
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}

