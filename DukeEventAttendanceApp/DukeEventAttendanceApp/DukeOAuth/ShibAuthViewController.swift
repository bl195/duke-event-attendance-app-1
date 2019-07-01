//
//  ShibAuthViewController.swift
//  WearDuke
//
//  Created by Erin Kelley on 5/21/19.
//  Copyright © 2019 Duke. All rights reserved.
//

import UIKit
import WebKit

/**
 * Loads a shibboleth page in a webview when no token is present and receives a token from the mobile authorization
 * server upon successful login.
 */
class ShibAuthViewController: UIViewController, WKNavigationDelegate {
    // Do not change the debug or release version names or else this #ifdef will break
    #if DEBUG
    let MOBILE_AUTH_BASE_URL = "https://mobile-authorizer-test.oit.duke.edu/"
    #else
    let MOBILE_AUTH_BASE_URL = "https://mobile-authorizer.api.oit.duke.edu/"
    #endif
    let LOGIN_PATH = "/ios/login"
    let TOKEN_PATH = "/ios/token?"
    
    typealias OAuthServiceCallbackClosure = (_ success: Bool) -> Void
    
    var webView: WKWebView?
    var numAttempts = 0
    var success = false
    var clientName: String?
    var oAuthServiceCallback: OAuthServiceCallbackClosure?
    
    let MAX_NUM_ATTEMPTS = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView = WKWebView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        webView!.navigationDelegate = self
        self.view.addSubview(webView!)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: (WKNavigationActionPolicy) -> Void) {
        decisionHandler(.allow)
        if let client  = clientName {
            let tokenUrl = MOBILE_AUTH_BASE_URL + client + TOKEN_PATH
            // Check url for the token string coming back from the mobile authorization server. If it's a match, parse the string and store the tokens.
            if (webView.url?.absoluteString.starts(with: tokenUrl))! {
                success = true
                OAuthService.shared.storeTokens(tokenStr: (webView.url?.query)!)
                if let _ = oAuthServiceCallback {
                    oAuthServiceCallback!(success)
                }
                numAttempts = 0
            }
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        if (navigationResponse.response .isKind(of: HTTPURLResponse.self)) {
            let response = navigationResponse.response as! HTTPURLResponse
            print("Login failed (webView outside) - trying again - attempt: \(numAttempts)")
            // Unsuccessful attempt, reload shib page and try again.
            if 400...500 ~= response.statusCode {
                print("Login failed - trying again - attempt: \(numAttempts)")
                numAttempts += 1
                loginShib()
            }
        }
        decisionHandler(WKNavigationResponsePolicy.allow)
    }
    
    /**
     * Loads the mobile authorization endpoint which will redirect to a shibboleth login and provide a token upon success.
     */
    func loginShib(completionHandler: ((_ success: Bool) -> Void)? = nil) {
        
        // Set callback to use when the user has shibed in, or when the MAX_NUM_ATTEMPTS has been reached.
        if let handler = completionHandler {
            oAuthServiceCallback = handler
        }
        
        // Let the user try to login through shib MAX_NUM_ATTEMPTS times. If they do not successfully shib in, then return a failure.
        if numAttempts < MAX_NUM_ATTEMPTS, let client = clientName {
            let loginURL = MOBILE_AUTH_BASE_URL + client + LOGIN_PATH
                webView!.load(NSURLRequest(url: NSURL(string: loginURL)! as URL) as URLRequest)
        } else if let _ = oAuthServiceCallback {
            oAuthServiceCallback!(success)
        }
    }
}
