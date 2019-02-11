//
//  SessionResponse.swift
//  OnTheMap
//
//  Created by SDK on 2/9/19.
//  Copyright © 2019 SDK. All rights reserved.
//

import Foundation

struct SessionResponse: Codable {
    let session: Session
    
    enum CodingKeys: String, CodingKey {
        case session
    }
}
