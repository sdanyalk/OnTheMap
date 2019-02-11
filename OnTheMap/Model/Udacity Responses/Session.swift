//
//  Session.swift
//  OnTheMap
//
//  Created by SDK on 2/9/19.
//  Copyright © 2019 SDK. All rights reserved.
//

import Foundation

struct Session: Codable {
    let id: String
    let expiration: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case expiration
    }
}
