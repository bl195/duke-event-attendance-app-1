
import UIKit

class QRCodeViewController: UIViewController {

    var event_id = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showScan") {
            let scanVC = segue.destination as? QRScannerController
            scanVC?.event_id = event_id
        }
        
    }
    
    
    
}
