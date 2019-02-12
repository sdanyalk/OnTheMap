//
//  StudentLocation.swift
//  OnTheMap
//
//  Created by SDK on 2/12/19.
//  Copyright © 2019 SDK. All rights reserved.
//

import Foundation

struct StudentLocation : Codable {
    
    let createdAt: String?
    let firstName: String?
    let lastName: String?
    let latitude: Double?
    let longitude: Double?
    let mapString: String?
    let mediaURL: String?
    let objectId: String?
    let updatedAt: String?
    let uniqueKey: String?
    
    enum CodingKeys: String, CodingKey {

        case createdAt
        case firstName
        case lastName
        case latitude
        case longitude
        case mapString
        case mediaURL
        case objectId
        case updatedAt
        case uniqueKey
    }
}
