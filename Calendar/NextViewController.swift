
import UIKit

class NextViewController: UIViewController {

    @IBOutlet weak var DateLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        DateLabel.text = dateString
    }
    
}
