//
//  Endpoints.swift
//  OnTheMap
//
//  Created by SDK on 2/9/19.
//  Copyright © 2019 SDK. All rights reserved.
//

import Foundation

enum Endpoints {
    
    static let udacityBase = "https://onthemap-api.udacity.com/v1"
    static let parseBase = "https://parse.udacity.com/parse/classes"
    
    case createSessionId
    case getStudentLocation
    
    var stringValue: String {
        switch self {
        case .createSessionId:
            return Endpoints.udacityBase + "/session"
            
        case .getStudentLocation:
            return Endpoints.parseBase + "/StudentLocation"
        }
    }
    
    var url: URL {
        return URL(string: stringValue)!
    }
}
