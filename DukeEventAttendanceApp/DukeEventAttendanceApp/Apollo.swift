//
//  Apollo.swift
//  DukeEventAttendanceApp
//
//  Created by Luiza Wolf on 7/2/19.
//  Copyright © 2019 Duke OIT. All rights reserved.
//

import Apollo
//let AUTH_HEADER = "Authorization"

class Apollo {
    
    // 1
    static let shared = Apollo()
    // 2
    //let client: ApolloClient
    //var token: OAuthService.shared.getAccessToken() ?? ""
    
    //var oAuthService: OAuthService?
   
    // = ApolloClient(url: URL(string: "http://localhost:3000/graphql")!)
    
    let client: ApolloClient = {
        let token = OAuthService.shared.getAccessToken() ?? ""
        print (token)
        let configuration = URLSessionConfiguration.default

        configuration.httpAdditionalHeaders = ["Authorization": "Bearer \(token)", "Content-Type": "application/json"]
        let kongURL = "https://events-attendance-backend.api-test.oit.duke.edu/graphql"
        let url = URL(string: kongURL)!
        return ApolloClient(networkTransport: HTTPNetworkTransport(url: url, configuration: configuration))

    }()
    
//    init() {
//        client = ApolloClient(url: URL(string: "http://localhost:3000/graphql")!)
//    }
    

    
}
