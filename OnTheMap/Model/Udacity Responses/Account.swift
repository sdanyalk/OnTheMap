//
//  Account.swift
//  OnTheMap
//
//  Created by SDK on 2/26/19.
//  Copyright © 2019 SDK. All rights reserved.
//

import Foundation

struct Account: Codable {
    let registered: Bool
    let key: String
    
    enum CodingKeys: String, CodingKey {
        case registered
        case key
    }
}
