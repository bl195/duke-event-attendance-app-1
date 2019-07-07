//
//  ViewController.swift
//  DukeEventAttendanceApp
//
//  Created by Luiza Wolf on 6/6/19.
//  Copyright © 2019 Duke OIT. All rights reserved.
//

import UIKit



class ViewController: UIViewController {
    var oAuthService: OAuthService?
    
    let AUTH_HEADER = "Authorization"

    @IBOutlet weak var photoImageView: UIImageView!
    
    
    @IBOutlet weak var logInButton: UIButton!
    
 

    @IBAction func logInPressed(_ sender: Any) {
        print("yay")
        oAuthService?.setClientName(oAuthClientName: "wearduke")
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
                    //self.navigationController?.dismiss(animated:true, completion: nil)
                    //self.navigationController?.dismiss(animated: true, completion: nil)
                    //self.performSegue(withIdentifier: "showMainFeed", sender: sender)
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.photoImageView.image = UIImage(named: "DukeCheck")
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        photoImageView.contentMode = .scaleAspectFit
        setUpLayout()
        
        oAuthService = OAuthService.shared
        
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
        logInButton.backgroundColor = UIColor(red: 1/255, green: 33/255, blue:105/255, alpha: 1.0)
        
        
        
        
        
        
        
        
        
    }
    
    
    
//    func isInGroup(navController: UINavigationController, completionHandler: @escaping (_ isInGroup: Bool, _ error: String?) -> Void) {
//
//        // Setup applo client
//
//        let apollo: ApolloClient = {
//
//            // Get access token to pass to in the request header
//
//            let token = OAuthService.shared.getAccessToken() ?? ""
//
//            // Configure timeout for the request
//
//            let configuration = URLSessionConfiguration.default
//            configuration.timeoutIntervalForRequest = 10    // in seconds
//
//            // Set headers for request
//
//            let apiKey = Bundle.main.infoDictionary?["GQL_API_KEY"] as? String
//
//            configuration.httpAdditionalHeaders = ["apikey": apiKey!, AUTH_HEADER: "Bearer \(token)", "Content-Type": "application/json"]
//
//            let gqlUrl = Bundle.main.infoDictionary?["GQL_AUTH_URL"] as? String
//
//            let url = URL(string: gqlUrl!)!
//
//            return ApolloClient(networkTransport: HTTPNetworkTransport(url: url, configuration: configuration))
//
//        }()
//
//
//        // Make an asynchronous call to the endpoint using the apollo client
//
//        apollo.fetch(query: GrouperCheck(), cachePolicy: .fetchIgnoringCacheData) { (result, error) in
//
//            if let err = error as? GraphQLHTTPResponseError {
//                switch (err.response.statusCode) {
//                case 401:
//
//                    // The request was unauthorized due to a bad token, request a new OAuth token.
//
//                    OAuthService.shared.refreshToken(navController: navController) { success, statusCode in
//                        if success {
//
//                            // We receieved a new token, try again.
//
//                            self.isInGroup(navController: navController) { isInGroup, error in
//
//                                completionHandler(isInGroup, error)
//
//                            }
//
//                        } else {
//
//                            // TODO: handle error
//
//                        }
//
//                    }
//
//                case 403:
//                    break
//
//                    // TODO: Handle not authorized (Forbidden) error
//
//                    //                    let message = ["title": "Unauthorized", "message": "You do not have access to this feature."]
//
//                    //                    self.showMessage(message: message)
//
//                case 500...599:
//                    break
//
//                    // TODO: handle GQL/Kong server error
//
//                    //                    self.onServerError()
//
//                default:
//
//                    // Something else went wrong, get a new token and try again
//
//                    OAuthService.shared.refreshToken(navController: navController) { success, statusCode in
//
//                        if success {
//
//                            self.isInGroup(navController: navController) { isInGroup, error in
//
//                                completionHandler(isInGroup, error)
//
//                            }
//
//                        } else {
//
//                            // TODO: handle error
//
//                        }
//
//                    }
//
//                }
//
//            } else if let err = error as NSError?, err.domain == NSURLErrorDomain {
//
//                // TODO: Handle error
//
//                //                let title = "Unexpected Error"
//
//                //                let message = err.localizedDescription
//
//                //                self.showMessage(message: ["title": title, "message": message])
//
//            } else {
//                if let res = result {
//                    if let data = res.data {
//                        if let inGroup = data.user?.wearDuke {
//                            // TODO: Handle error
//                            completionHandler(inGroup, nil)
//                        } else {
//                            // TODO: Handle error
//                        }
//
//                    } else {
//
//                        // graphql server error handling
//
//                        // TODO: Handle error
//
//                        //                        if let errors = res.errors, !errors.isEmpty {
//
//                        //                            let message = ["title": "Server Error", "message": errors[0].message]
//
//                        //                            self.showMessage(message: message as! [String : String])
//
//                        //                        } else {
//
//                        //                            self.onServerError()
//
//                        //                        }
//
//                    }
//
//                } else {
//
//                    // Error catch-all
//
//                    // TODO: Handle error
//
//                    //                    self.onServerError()
//
//                }
//
//            }
//
//        }
//
//    }
    
    



}

