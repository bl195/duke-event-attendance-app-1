
import UIKit

class SideBarTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //switch
        let my_switch = UISwitch(frame: .zero)
        my_switch.isOn = switchOn
        my_switch.addTarget(self, action: #selector(switchToggled(_:)), for: .valueChanged)
        let switch_display = UIBarButtonItem(customView: my_switch)
        navigationItem.rightBarButtonItems = [cal, switch_display]
        
        
        //settings bar
        let settings_display = UIBarButtonItem(image: UIImage(named: "icons8-settings-24"), style: .done, target: self, action: #selector(tapButton))
        
        navigationItem.leftBarButtonItems = [topicfilter, settings_display]
        
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
}
