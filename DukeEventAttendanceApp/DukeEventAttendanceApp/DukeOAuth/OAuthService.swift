//
//  OAuthService.swift
//  WearDuke
//
//  Created by Erin Kelley on 5/21/19.
//  Copyright © 2019 Duke. All rights reserved.
//

import Foundation
import UIKit
import SwiftKeychainWrapper

/* OAuthService allows a user to authenticate with Duke University's OAuth implementation.
 * The access token is a large random number used for OAuth authentication. The session token
 * is a large random number that is passed to the mobile authorization server (in addition
 * to the access token) when an access token needs to be refreshed so the server can verify
 * who the user. */
class OAuthService {
    // Do not change the debug or release version names or else this #ifdef will break
    #if DEBUG
    let MOBILE_AUTH_BASE_URL = "https://mobile-authorizer-test.oit.duke.edu/"
    #else
    let MOBILE_AUTH_BASE_URL = "https://mobile-authorizer.api.oit.duke.edu/"
    #endif
    let REFRESH_PATH = "/ios/refresh"
    let REVOKE_PATH = "/ios/revoke"
    
    let ACCESS_TOKEN_HEADER = "X-Access-Token"
    let SESSION_TOKEN_HEADER = "X-Session-Token"
    let API_KEY_HEADER = "apikey"
    let ACCESS_TOKEN_KEY = "access_token"
    let SESSION_TOKEN_KEY = "session_token"
    let ACCESS_TOKEN_ID = "access_token="
    let SESSION_TOKEN_ID = "session_token="
    
    let HTTP_POST = "POST"
    let OAUTH_CLIENT_NAME_KEY = "oAuthClientName"
    
    var numAttempts = 0
    
    static let shared = OAuthService()
    
    /**
     * Sets the name of the client so the mobile authorization server knows which oauth client to deal with.
     * @param oAuthClientName The name of the application.
     */
    func setClientName(oAuthClientName: String) {
        UserDefaults.standard.set(oAuthClientName, forKey: OAUTH_CLIENT_NAME_KEY)
    }
    
    /**
     * Authenticates a user through opening a shibboleth page in a webview.
     * @return a completetion handler with the success of authenticating.
     */
    func authenticate(navController: UINavigationController, completionHandler: @escaping (_ success: Bool) -> Void) {
        let clientName = UserDefaults.standard.string(forKey: OAUTH_CLIENT_NAME_KEY)
        if let client = clientName {
            // Create and push the ViewController that will house the webview for the shibboleth page and the token response from the mobile authorization server
            let shibController = ShibAuthViewController()
            shibController.clientName = client
            CATransaction.begin()
            navController.pushViewController(shibController, animated: true)
            CATransaction.setCompletionBlock({
                shibController.loginShib() { success in
                    // Return the success to the calling application
                    completionHandler(success)
                }
            })
            CATransaction.commit()
        } else {
            completionHandler(false)
        }
    }
    
    /**
     * Checks if a user is authenticated.
     * @return whether the user is authenticated.
     */
    func isAuthenticated() -> Bool {
        if !(getAccessToken() ?? "").isEmpty || !(getSessionToken() ?? "").isEmpty {
            return true
        }
        
        return false
    }
    
    /**
     * Getter for the access token.
     * @return the access token.
     */
    func getAccessToken() -> String? {
        return KeychainWrapper.standard.string(forKey: ACCESS_TOKEN_KEY)
    }
    
    /**
     * Getter for the session token.
     * @return the session token.
     */
    func getSessionToken() -> String? {
        return KeychainWrapper.standard.string(forKey: SESSION_TOKEN_KEY)
    }
    
    /**
     * Requests a new token if the current token is no longer valid. On a 400 from the mobile authorization server,
     * a shibboleth page will open to reauthenticate the user and the current tokens will be removed from the keychain and mobile authorization server.
     * @return a completion handler with the success of the refresh and the response status code.
     */
    func refreshToken(navController: UINavigationController, completionHandler: @escaping (_ success: Bool, _ code: Int) -> Void) {
        let clientName = UserDefaults.standard.string(forKey: OAUTH_CLIENT_NAME_KEY)
        if let client = clientName {
            // Request a new token from the mobile authorization server, passing in the access and session tokens
            let refreshUrl = MOBILE_AUTH_BASE_URL + client + REFRESH_PATH
            var request = URLRequest(url: URL(string: refreshUrl)!)
            request.addValue(getAccessToken()!, forHTTPHeaderField: ACCESS_TOKEN_HEADER)
            request.addValue(getSessionToken()!, forHTTPHeaderField: SESSION_TOKEN_HEADER)
            request.httpMethod = HTTP_POST
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    //                print("error=\(String(describing: error))")
                    return
                }
                
                if let err = error as NSError?, err.domain == NSURLErrorDomain {
                    completionHandler(false, err.code)
                }
                
                if let response = response as? HTTPURLResponse {
                    switch response.statusCode {
                    case 200:
                        // Success, parse and store the refreshed token
                        self.parseRefreshTokenResponse(data: data)
                        completionHandler(true, response.statusCode)
                    case 400:
                        // Token is no longer recognized as valid. Remove tokens from the device and
                        // mobile authorization server, and go through the whole authorization process again.
                        self.clearStoredTokens()
                        self.authenticate(navController: navController) { success in
                            if success {
                                completionHandler(success, 200)
                            } else {
                                completionHandler(success, response.statusCode)
                            }
                        }
                    case 500...599:
                        completionHandler(false, response.statusCode)
                    default:
                        self.authenticate(navController: navController) { success in
                            completionHandler(success, response.statusCode)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    /**
     * Parses the token string and stores the access token and session token on the Keychain.
     */
    internal func storeTokens(tokenStr: String) {
        let split = tokenStr.split(separator: "&")
        let access_token = split[0].replacingOccurrences(of: ACCESS_TOKEN_ID, with: "")
        let session_token = split[1].replacingOccurrences(of: SESSION_TOKEN_ID, with: "")
        KeychainWrapper.standard.set(access_token, forKey: ACCESS_TOKEN_KEY)
        KeychainWrapper.standard.set(session_token, forKey: SESSION_TOKEN_KEY)
    }
    
    /**
     * Parses the refresh token response from the mobile authorization server and stores the new token on the Keychain.
     */
    private func parseRefreshTokenResponse(data: Data) {
        do {
            let decoder = JSONDecoder()
            let tokens = try decoder.decode(JSONData.self, from: data)
            KeychainWrapper.standard.set(tokens.data.accessToken, forKey: ACCESS_TOKEN_KEY)
            KeychainWrapper.standard.set(tokens.data.sessionToken, forKey: SESSION_TOKEN_KEY)
        } catch let error {
            //            print("error=\(error)")
        }
    }
    
    /**
     * Removes the token from the Keychain and makes a call to the mobile authorization server to remove the token from its database.
     */
    func logout() {
        clearStoredTokens()
    }
    
    /**
     * Removes the token from the Keychain and makes a call to the mobile authorization server to remove the token from its database.
     */
    private func clearStoredTokens() {
        let clientName = UserDefaults.standard.string(forKey: OAUTH_CLIENT_NAME_KEY)
        
        // send request to remove tokens from mobile authorization server database. Pass both tokens as headers.
        if let client = clientName {
            let revokeUrl = MOBILE_AUTH_BASE_URL + client + REVOKE_PATH
            var request = URLRequest(url: URL(string: revokeUrl)!)
            request.addValue(getAccessToken()!, forHTTPHeaderField: ACCESS_TOKEN_HEADER)
            request.addValue(getSessionToken()!, forHTTPHeaderField: SESSION_TOKEN_HEADER)
            request.httpMethod = HTTP_POST
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let _ = data, error == nil else {
                    //                print("error=\(String(describing: error))")
                    return
                }
            }
            task.resume()
            
            // clear the keychain of the tokens
            KeychainWrapper.standard.removeObject(forKey: ACCESS_TOKEN_KEY)
            KeychainWrapper.standard.removeObject(forKey: SESSION_TOKEN_KEY)
        }
    }
}

struct JSONData: Decodable {
    let data: Tokens
}

struct Tokens: Decodable {
    let accessToken: String
    let sessionToken: String
    
    private enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case sessionToken = "session_token"
    }
}
