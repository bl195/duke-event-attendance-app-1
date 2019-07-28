//
//  AgendaTableViewCell.swift
//  DukeEventAttendanceApp
//
//  Created by Luiza Wolf on 6/19/19.
//  Copyright © 2019 Duke OIT. All rights reserved.
//

import UIKit

protocol AgendaTableViewCellDelegate {
    func didTapCheckIn(event:Event)
}

class AgendaTableViewCell: UITableViewCell {
    
    var event: Event!
    var delegate: AgendaTableViewCellDelegate?
    var active = true

    @IBOutlet weak var monthLabel: UILabel!
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var locLabel: UILabel!
    
    @IBOutlet weak var checkInButton: UIButton!
    @IBOutlet weak var backgroundCard: UIView!
    
    @IBAction func checkInTapped(_ sender: Any) {
        delegate?.didTapCheckIn(event: self.event)
        //eventTitle.textAlignment = NSTextAlignment.natural
    }
    
    func setEvent(event: Event){
        self.event = event
        if( !self.active ){
            self.checkInButton.isEnabled = false
            self.checkInButton.setTitle("C H E C K - I N  N O T  A V A I L A B L E", for: .disabled)
            self.checkInButton.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        }
    }
    
    //    @IBAction func sendToDB(_ sender: Any) {
//        //hitAPI(_for: "http://localhost:3000/events/create", title: title, text: id)
//        hitAPI2(_for: base_url, dukecal_id: id, duid: "6033006990222254")
//    }
////
//    func hitAPI2(_for URLString:String, dukecal_id: String, duid: String) {
//        var actual_id = dukecal_id.replacingOccurrences(of: "@", with: "-")
//        actual_id = actual_id.replacingOccurrences(of: ".", with: "-")
//        actual_id = actual_id.lowercased()
//        base_url = base_url + actual_id + "/attendees/addAttendee"
//        print(base_url)
//
//        guard let url = URL(string: URLString) else {return}
//
//        var request : URLRequest = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.addValue("application/json", forHTTPHeaderField: "Accept")
//        let params = ["duid": duid]
//
//        let jsonData = try! JSONSerialization.data(withJSONObject: params, options: [])
//        request.httpBody = jsonData
//        print("jsonData: ", String(data: request.httpBody!, encoding: .utf8) ?? "no body data")
//
//
//        let session = URLSession.shared
//        let task = session.dataTask(with: request) { (responseData, response, responseError) in
//            if let responseData = responseData {
//                do {
//                    let json = try JSONSerialization.jsonObject(with: responseData, options: [])
//                    print(json)
//                } catch {
//                    print(responseError)
//                }
//            }
//        }
//        task.resume()
//
//    }
//    func hitAPI(_for URLString:String, title: String, text: String) {
//
//        guard let url = URL(string: URLString) else {return}
//
//        var request : URLRequest = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.addValue("application/json", forHTTPHeaderField: "Accept")
//        let params = ["title": title, "dukecal_id": text]
//
//        let jsonData = try! JSONSerialization.data(withJSONObject: params, options: [])
//        request.httpBody = jsonData
//        print("jsonData: ", String(data: request.httpBody!, encoding: .utf8) ?? "no body data")
//
//
//        let session = URLSession.shared
//        let task = session.dataTask(with: request) { (responseData, response, responseError) in
//            if let responseData = responseData {
//                do {
//                    let json = try JSONSerialization.jsonObject(with: responseData, options: [])
//                    print(json)
//                } catch {
//                    print(responseError)
//                }
//            }
//        }
//        task.resume()
//
//    }
//

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}

