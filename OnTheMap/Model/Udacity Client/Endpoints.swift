//
//  Endpoints.swift
//  OnTheMap
//
//  Created by SDK on 2/9/19.
//  Copyright © 2019 SDK. All rights reserved.
//

import Foundation

enum Endpoints {
    
    static let base = "https://onthemap-api.udacity.com/v1"
    
    case createSessionId
    
    var stringValue: String {
        switch self {
        case .createSessionId:
            return Endpoints.base + "/session"
        }
    }
    
    var url: URL {
        return URL(string: stringValue)!
    }
}
