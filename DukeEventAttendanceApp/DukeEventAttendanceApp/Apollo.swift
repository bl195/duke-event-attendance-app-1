//
//  Apollo.swift
//  DukeEventAttendanceApp
//
//  Created by Jessica Su on 7/2/19.
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
    }
    
}

