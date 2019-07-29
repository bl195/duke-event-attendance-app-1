//
//  EventTableViewController.swift
//  DukeEventAttendanceApp
//
//  Created by Luiza Wolf on 6/6/19.
//  Copyright © 2019 Duke OIT. All rights reserved.
//

import UIKit


class EventTableViewController: UITableViewController {
    var eventArray = [Event]()
    var filteredEvents = [Event]()
    var filtername = ""
    
    var oAuthService: OAuthService?
    var menuFilterName = ""
    var encodedate = ""
    var ongoing: Bool = false
    var switchOn: Bool = false
    var searchController = UISearchController(searchResultsController: nil)
    var menuFilter: Bool = false
    var dateFilter: Bool = false
    
    
    //initialize calendar
    @IBOutlet weak var topicfilter: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        oAuthService = OAuthService.shared
        //switch bar
        let logout = UIBarButtonItem(image: UIImage(named: "logout"), style: .done, target: self, action: #selector(tapButton))
        let my_switch = UISwitch(frame: .zero)
        my_switch.isOn = switchOn
        my_switch.addTarget(self, action: #selector(switchToggled(_:)), for: .valueChanged)
        let switch_display = UIBarButtonItem(customView: my_switch)
        navigationItem.rightBarButtonItems = [logout,switch_display]
        
    
   
        
        
//
//        navigationItem.leftBarButtonItems = [topicfilter, settings_display]
        
        
        
   //-------------------------------------------------------------------------------------------
        
        
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.loadSampleEvents(filter: filtername, date: encodedate, ongoing: ongoing)
        

        //self.hitAPI(_for: "http://localhost:3000/createArticleMobile")
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Events"
        
        
       
        
        navigationItem.searchController = searchController
        
        let textFieldInsideSearchBar = searchController.searchBar.value(forKey: "searchField") as? UITextField
        
        textFieldInsideSearchBar?.textColor = UIColor.white
        searchController.searchBar.tintColor = UIColor.white
        
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        //let bounds = self.navigationController!.navigationBar.bounds
        //self.navigationController?.navigationBar.frame = CGRect (x: 0, y: 0, width: bounds.width, height: bounds.height + 150)
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        let height: CGFloat = 70 //whatever height you want to add to the existing height
//        let bounds = self.navigationController!.navigationBar.bounds
//        self.navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height + height)
//        //self.navigationController?.navigationBar.barTintColor = UIColor.blue
//
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let textFieldInsideSearchBar = searchController.searchBar.value(forKey: "searchField") as? UITextField
        
        textFieldInsideSearchBar?.textColor = UIColor.white
        searchController.searchBar.tintColor = UIColor.white
        
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

            // APIs usually respond with the data you just sent in your POST request
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
    
    @objc func tapButton(){
        let alert = UIAlertController(title: "Logout", message: "Do you want to Log out?", preferredStyle: .alert)
        let subButton = UIAlertAction(title: "Yes", style: .default, handler: { (action) -> Void in
            self.oAuthService?.logout()
            print (self.oAuthService?.isAuthenticated())
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "mainNav") as? UINavigationController
            self.navigationController?.present(vc!, animated: true)
            
            print("logged out")
            
        })
        let cancelButton = UIAlertAction(title: "No", style: .cancel, handler: nil)
        alert.addAction(subButton)
        alert.addAction(cancelButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source
    
    @IBAction func switchToggled(_ sender: UISwitch) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "EventTableViewController") as? EventTableViewController
        if sender.isOn {
            vc?.ongoing = true
            vc?.switchOn = true
        }
        else{
            vc?.ongoing = false
            vc?.switchOn = false
        }
        vc?.encodedate = self.encodedate
        vc?.filtername = self.filtername
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        //print ("here")
        let textFieldInsideSearchBar = searchController.searchBar.value(forKey: "searchField") as? UITextField
        
        textFieldInsideSearchBar?.textColor = UIColor.white
        filteredEvents = eventArray.filter({( event:Event) -> Bool in
            return event.summary.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "calendarSegue") {
            let calVC = segue.destination as? CalendarViewController
            calVC?.filter = filtername 
        }
        
        if (segue.identifier == "menuSegue") {
            let menuVC = segue.destination as? MenuViewController
            menuVC?.thisDateCode = encodedate
        }
        
        let backItem = UIBarButtonItem()
        backItem.title = "BACK"
        navigationItem.backBarButtonItem = backItem // This will show in the
    }

    
    private func loadSampleEvents(filter: String, date: String, ongoing: Bool){
        var filtername1 = filter.replacingOccurrences(of: " ", with: "+")
        filtername1 = "&topic=" + filtername1
        //filtername = filter.replacingOccurrences(of: " ", with: "+")
        filtername1.replacingOccurrences(of: "/", with: "%2F")
        filtername1.replacingOccurrences(of: "&", with: "%26")
        print(filter)
        var day_range = "90"
        //var filter = "" //&gfu[]=Career%20Center"
        /*
        if filter == "Home" {
            filtername = ""
        }
 */
        var spec_url = "https://calendar.duke.edu/events/index.json?" + filtername1 + "&future_days=" + day_range + "&user_date=" + date + "&feed_type=simple" + "&local=true"
        
        
        NetworkManager.downloadCalendarInfo(specific_url: spec_url) { jsonData in
            
            if let events = jsonData["events"] as? Array<Dictionary<String,Any>>{
                
                for event in events{
  
                    guard let event0 = Event(id: event["id"] as? String ?? "",
                                             start_date: event["start_timestamp"] as? String ?? "",
                                             end_date: event["end_timestamp"] as? String ?? "",
                                             summary: event["summary"] as? String ?? "",
                                             description: event["description"] as? String ?? "",
                                             status: event["status"] as? String ?? "",
                                             sponsor: event["sponsor"] as? String ?? "",
                                             co_sponsors: event["co_sponsors"] as? String ?? "",
                                             location: event["location"] as! Dictionary<String,String>,
                                             contact: event["contact"] as! Dictionary<String,String>,
                                             categories: event["categories"] as? [String] ?? ["no category"],
                                             link: event["link"] as? String ?? "",
                                             event_url: event["event_url"] as? String ?? "",
                                             series_name: event["series_name"] as? String ?? "",
                                             image_url: event["image"] as? String ?? "")
                        else{
                            fatalError("Unable to instantiate event")
                    }

                    var eventOngoing:Bool = true
                    if( (event0.startmonth + event0.startday) == (event0.endmonth + event0.endday) ){
                        eventOngoing = false
                    }
                    if( eventOngoing ){
                        event0.makeOngoing()
                    }
                    
                    if( !ongoing && !eventOngoing){
                        self.eventArray.append( event0 )
                    }
                    
                    if( ongoing ){
                        self.eventArray.append( event0 )
                    }
                    
                    Items.sharedInstance.id_event_dict[event0.id] = event0
                    //self.hitAPI(_for: "http://localhost:3000/createArticleMobile", title: event0.start_date, text: event0.summary)
                }
                Items.sharedInstance.eventArray = self.eventArray
                // Downloading data from network is asynchronous, after download is done, need to inform table view to reload data to refresh UI.
                // UI refresh needs to happen on main UI thread and the completion handler is already called on main thread.
                //DispatchQueue.main.async() {
                self.tableView.reloadData()
                //}
            }
        }
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if isFiltering(){
            return filteredEvents.count
        }
        
        return eventArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EventTableViewCell", for: indexPath) as? EventTableViewCell else{
            fatalError("the cell is not an instance of the table view cell")
        }
        // Configure the cell...
        let event:Event
        if isFiltering(){
            event = self.filteredEvents[indexPath.row]
        } else{
            event = self.eventArray[indexPath.row]
        }
        cell.nameLabel.text = event.summary
        
        // Need to check if url can be created successfully
        //if let imageUrl = URL(string: event.image_url) {
        //  TESTING with a fixed image url as event's image_url is empty
        if let imageUrl = URL(string: event.image_url) {
            // This is a network call and needs to be run on non-UI thread
            DispatchQueue.global().async {
                let imageData = try! Data(contentsOf: imageUrl)
                let image = UIImage(data: imageData)
                DispatchQueue.main.async {
                    cell.photoImageView.image = image
                }
            }
        }
        //cell.photoImageView.image = event.getImage()
        
        // scell.photoImageView.contentMode = UIView.ContentMode.center
        cell.photoImageView.contentMode = UIView.ContentMode.scaleAspectFill
        cell.photoImageView.layer.cornerRadius = 10.0
        cell.photoImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        cell.photoImageView.clipsToBounds = true
        
        cell.backgroundCard.layer.cornerRadius = 10.0
        cell.backgroundCard.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        cell.backgroundCard.clipsToBounds = true
        cell.backgroundCard.backgroundColor = UIColor(red: 1/255, green: 33/255, blue:105/255, alpha: 1.0)
        cell.dateLabel.textColor = UIColor.white
        cell.nameLabel.textColor = UIColor.white
        cell.locationLabel.textColor = UIColor.white
        
        cell.dateLabel.text = event.start_date
        cell.locationLabel.text = event.address
        
        if( event.ongoing ){
            cell.backgroundCard.backgroundColor = UIColor(red: 226/255, green: 230/255, blue:237/255, alpha: 1.0)
            cell.dateLabel.textColor = UIColor.black
            cell.nameLabel.textColor = UIColor.black
            cell.locationLabel.textColor = UIColor.black
            cell.dateLabel.text = "Ongoing"
        }
        
   
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "EventInfoViewController") as? EventInfoViewController
        var thisArray = [Event]()
        if isFiltering(){
            thisArray = filteredEvents
        }
        else{
            thisArray = eventArray
        }
        vc?.event = thisArray[indexPath.row]
        vc?.id = thisArray[indexPath.row].id
        vc?.event = thisArray[indexPath.row]
        vc?.sum = thisArray[indexPath.row].summary
        vc?.sdl = thisArray[indexPath.row].startday
        vc?.sml = thisArray[indexPath.row].startmonth
        vc?.ll = thisArray[indexPath.row].address
        vc?.imageURL = thisArray[indexPath.row].image_url
        vc?.backupURL = thisArray[indexPath.row].link
        vc?.webEventURL = thisArray[indexPath.row].event_url
        vc?.tl = thisArray[indexPath.row].starttime + " - " + self.eventArray[indexPath.row].endtime
        if( thisArray[indexPath.row].ongoing ){
            vc?.tl = "Ongoing"
        }
        vc?.dl = thisArray[indexPath.row].description
        print(thisArray[indexPath.row].description)
        vc?.ldl = thisArray[indexPath.row].start_date
        if( thisArray[indexPath.row].ongoing ){
            vc?.ldl = thisArray[indexPath.row].start_date + " - " + thisArray[indexPath.row].end_date
        }
        vc?.sl = thisArray[indexPath.row].sponsor
        self.navigationController?.show(vc!, sender: true)
        //present(vc!, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        print ("add")
        var currArray = [Event]()
        if isFiltering() {
            currArray = filteredEvents
        }
        else {
            currArray = eventArray
        }
        let agendaAction = UITableViewRowAction (style: .default, title: "Add to Agenda"){ [weak self] (_, indexPath ) in
            let ev = EventID(context: PersistenceService.context )
            ev.id = currArray[indexPath.row].id
            PersistenceService.saveContext()
        }
        agendaAction.backgroundColor = UIColor(red: 1/255, green: 33/255, blue:105/255, alpha: 1.0)
        return [agendaAction]
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension EventTableViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
