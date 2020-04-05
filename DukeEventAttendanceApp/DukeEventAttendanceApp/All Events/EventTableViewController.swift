//
//  EventTableViewController.swift
//  DukeEventAttendanceApp
//
//  Created by Luiza Wolf on 6/6/19.
//  Copyright © 2019 Duke OIT. All rights reserved.
//

import UIKit

/**
 Manages table view contained within AllEventsViewController
 Populated with all relevant events from Duke Event Calendar
 */

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
    
    @IBOutlet weak var topicfilter: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        oAuthService = OAuthService.shared
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.loadDukeCalEvents(filter: filtername, date: encodedate, ongoing: ongoing)
        
        /*
         Menu bar items above the event table
         Includes logout button, search bar, ongoing events filter
         */
        let logout = UIBarButtonItem(image: UIImage(named: "logout"), style: .done, target: self, action: #selector(logOutTapped))
        // Ongoing events switch
        let ongoing_switch = UISwitch(frame: .zero)
        ongoing_switch.isOn = switchOn
        ongoing_switch.addTarget(self, action: #selector(ongoingSwitchToggled(_:)), for: .valueChanged)
        let switch_display = UIBarButtonItem(customView: ongoing_switch)
        navigationItem.rightBarButtonItems = [logout,switch_display]
        // Settings for search bar
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Events"
        navigationItem.searchController = searchController
        
        let textFieldInsideSearchBar = searchController.searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = UIColor.white
        searchController.searchBar.tintColor = UIColor.white
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
    
    
    
    //MARK: - Table view data source
    
    /**
     Populates the table with events from Duke Calendar by hitting the Duke Event Calendar API
     - parameters:
     - filter: topic filters from menu
     - date: date filter from menu or current date
     - ongoing: true if ongoing events are to be included
     
     - Parameters are used to construct a URL for the network call
     - The JSON data returned contains an array of dictionaries to represent the event information
     - This method parses through the array and instantiates an event0 object which is then appended to the class variable eventArray
     - eventArray is assigned to Items.sharedInstance.eventArray, which is the table's data source
     */
    private func loadDukeCalEvents(filter: String, date: String, ongoing: Bool){
        var filter = filter.replacingOccurrences(of: " ", with: "+")
        filter = "&topic=" + filter
        let day_range = "90"
        let spec_url = "https://calendar.duke.edu/events/index.json?" + filter + "&future_days=" + day_range + "&user_date=" + date + "&feed_type=simple&local=true"
        
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
                }
                Items.sharedInstance.eventArray = self.eventArray
                self.tableView.reloadData()
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering(){
            return filteredEvents.count
        }
        
        return eventArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EventTableViewCell", for: indexPath) as? EventTableViewCell else{
            fatalError("the cell is not an instance of the table view cell")
        }
        
        let event:Event
        if isFiltering(){
            event = self.filteredEvents[indexPath.row]
        } else{
            event = self.eventArray[indexPath.row]
        }
        cell.nameLabel.text = event.summary
        
        if let imageUrl = URL(string: event.image_url) {
            // This is a network call and needs to be run on non-UI thread
            DispatchQueue.global().async {
                let imageData = try? Data(contentsOf: imageUrl)
                let backupImage = try! Data(contentsOf: URL(string: getRandomImageURL())!)
                let image = UIImage(data: imageData ?? backupImage)
                DispatchQueue.main.async {
                    cell.photoImageView.image = image
                }
            }
        }
        
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
    
    /**
     Filters events in the table to include or exclude ongoing events (i.e. events that span multiple days)
     */
    @IBAction func ongoingSwitchToggled(_ sender: UISwitch) {
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
    
    /**
     Checks if the search bar contains any text
     - returns: true if the text is empty or nil, false otherwise
     */
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    /**
     Filters events in table to only show events whose summaries/titles contain the same text as is present in the search bar
     - parameters:
     - searchText: text in search bar
     */
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        let textFieldInsideSearchBar = searchController.searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = UIColor.white
        
        filteredEvents = eventArray.filter({( event:Event) -> Bool in
            return event.summary.lowercased().contains(searchText.lowercased())
        })
        //TODO: Modify to include events with matching text in their descriptions, not just titles
        
        tableView.reloadData()
    }
    
    /**
     - returns: bool of whether or not the search bar is being used to filter events
     */
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    
    
    
    //MARK: - Navigation
    
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
    
    /**
     Logs current user out of account using oAuth if logout button is tapped
     */
    @objc func logOutTapped(){
        let alert = UIAlertController(title: "Logout", message: "Do you want to Log out?", preferredStyle: .alert)
        let subButton = UIAlertAction(title: "Yes", style: .default, handler: { (action) -> Void in
            self.oAuthService?.logout()
            print(self.oAuthService?.isAuthenticated())
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "mainNav") as? UINavigationController
            self.navigationController?.present(vc!, animated: true)
            print("logged out")
        })
        let cancelButton = UIAlertAction(title: "No", style: .cancel, handler: nil)
        alert.addAction(subButton)
        alert.addAction(cancelButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    
}

extension EventTableViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}

