//
//  PostStudentLocationResponse.swift
//  OnTheMap
//
//  Created by SDK on 2/25/19.
//  Copyright © 2019 SDK. All rights reserved.
//

import Foundation

struct PostStudentResponse: Codable {
    
    let createdAt: String?
    let objectId: String?
    
    enum CodingKeys: String, CodingKey {
        
        case createdAt
        case objectId
    }
}
