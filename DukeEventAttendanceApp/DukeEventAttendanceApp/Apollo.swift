//
//  Apollo.swift
//  DukeEventAttendanceApp
//
//  Created by Luiza Wolf on 7/2/19.
//  Copyright © 2019 Duke OIT. All rights reserved.
//

import Apollo

class Apollo {
    
    // 1
    static let shared = Apollo()
    // 2
    let client: ApolloClient
    
    init() {
        // 3
        client = ApolloClient(url: URL(string: "http://localhost:3000/graphql")!)
        //client = ApolloClient(url: URL(string: "https://events-attendance-backend-test.cloud.duke.edu/graphiql")!)
    }
    
}
