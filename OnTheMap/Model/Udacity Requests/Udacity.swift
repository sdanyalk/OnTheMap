//
//  Udacity.swift
//  OnTheMap
//
//  Created by SDK on 2/10/19.
//  Copyright © 2019 SDK. All rights reserved.
//

import Foundation

struct Udacity: Codable {
    
    let username: String
    let password: String
    
    enum CodingKeys: String, CodingKey {
        case username
        case password
    }
}
