//
//  SessionDeleteResponse.swift
//  OnTheMap
//
//  Created by SDK on 3/8/19.
//  Copyright © 2019 SDK. All rights reserved.
//

import Foundation

struct SessionDeleteResponse: Codable {
    let session: Session
    
    enum CodingKeys: String, CodingKey {
        case session
    }
}
