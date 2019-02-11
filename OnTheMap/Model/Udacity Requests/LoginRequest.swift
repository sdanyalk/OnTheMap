//
//  LoginRequest.swift
//  OnTheMap
//
//  Created by SDK on 2/9/19.
//  Copyright © 2019 SDK. All rights reserved.
//

import Foundation

struct LoginRequest: Codable {
    
    let udacity: Udacity
    
    enum CodingKeys: String, CodingKey {
        case udacity
    }
}
