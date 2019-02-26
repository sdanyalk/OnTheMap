//
//  StudentLocation.swift
//  OnTheMap
//
//  Created by SDK on 2/12/19.
//  Copyright © 2019 SDK. All rights reserved.
//

import Foundation

struct StudentLocation : Codable {
    
    var createdAt: String?
    var firstName: String?
    var lastName: String?
    var latitude: Double?
    var longitude: Double?
    var mapString: String?
    var mediaURL: String?
    var objectId: String?
    var updatedAt: String?
    var uniqueKey: String?
    
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
