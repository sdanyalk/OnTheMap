//
//  UserInfoResponse.swift
//  OnTheMap
//
//  Created by SDK on 2/26/19.
//  Copyright © 2019 SDK. All rights reserved.
//

import Foundation

struct UserInfoResponse: Codable {
    let name: String
    let firstName: String
    let lastName: String
    
    enum CodingKeys: String, CodingKey {
        case name = "nickname"
        case firstName = "first_name"
        case lastName = "last_name"
    }
}
