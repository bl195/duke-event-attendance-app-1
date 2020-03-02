
import UIKit

import Apollo

class ViewController: UIViewController {
    var oAuthService: OAuthService?
    
    let AUTH_HEADER = "Authorization"

    @IBOutlet weak var photoImageView: UIImageView!
    
    
    @IBOutlet weak var logInButton: UIButton!
    
    override func viewDidLoad() {
        oAuthService = OAuthService.shared
        //oAuthService?.logout()
        if ((oAuthService?.isAuthenticated())!) {
            let feedVC = self.storyboard?.instantiateViewController(withIdentifier: "mainFeed") as? UITabBarController
            self.present(feedVC!, animated: true, completion: nil)
        }
       
        self.photoImageView.image = UIImage(named: "dukecheck-1")
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        photoImageView.contentMode = .scaleAspectFit
        setUpLayout()
        self.navigationController?.navigationBar.isHidden = true
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func logInPressed(_ sender: Any) {
        //oAuthService?.logout()
        //print("yay")
        oAuthService?.setClientName(oAuthClientName: "dukeeventattendance")
        if oAuthService!.isAuthenticated() {
            print ("Login")
            oAuthService?.refreshToken(navController: self.navigationController!) { success, statusCode in
                if success {
                   //UserDefaults.standard.set(true, forKey: "LoggedIn")
                    print ("SUCCESS")
                    DispatchQueue.main.async {
                        let tabVC = self.storyboard?.instantiateViewController(withIdentifier: "mainFeed") as? UITabBarController
                        self.present(tabVC!, animated: true, completion: nil)
                    }
                }
            }
        }
        else if let navController = navigationController {
            print ("Log in")
            oAuthService?.authenticate(navController: navController) {success in
                if success {
                    print ("LOGIN SUCCESS")
                    DispatchQueue.main.async {
                        let tabVC = self.storyboard?.instantiateViewController(withIdentifier: "mainFeed") as? UITabBarController
                        self.present(tabVC!, animated: false, completion: nil)
                    }
                    
                } else {
                    print ("LOGIN FAILED")
                }
            }
                
        }
    }
    
    private func setUpLayout() {
        let topImageContainerView = UIView()
        //topImageContainerView.backgroundColor = .blue
        view.addSubview(topImageContainerView)
        //enable autolayout
        topImageContainerView.translatesAutoresizingMaskIntoConstraints = false
        topImageContainerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        //better to use trailing and leading anchor rather than left and right anchor
        topImageContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topImageContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        topImageContainerView.addSubview(photoImageView)
        photoImageView.centerXAnchor.constraint(equalTo: topImageContainerView.centerXAnchor).isActive = true
        photoImageView.centerYAnchor.constraint(equalTo: topImageContainerView.centerYAnchor).isActive = true
        photoImageView.heightAnchor.constraint(equalTo: topImageContainerView.heightAnchor, multiplier: 0.5).isActive = true
        
        //making sure the top container is 3/4 the size of the entire screen
        topImageContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.75).isActive = true
        
        logInButton.translatesAutoresizingMaskIntoConstraints = false
        logInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logInButton.widthAnchor.constraint(equalToConstant: 156).isActive = true
        logInButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
        logInButton.topAnchor.constraint(equalTo: topImageContainerView.bottomAnchor).isActive = true
        logInButton.backgroundColor = UIColor(red: 255/255, green: 255/255, blue:255/255, alpha: 0.5)
        
    }

}

