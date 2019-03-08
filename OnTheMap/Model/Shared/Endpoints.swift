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
    case postStudentLocation
    case getUserInfo
    
    var stringValue: String {
        switch self {
        case .createSessionId:
            return Endpoints.udacityBase + "/session"
            
        case .getStudentLocation:
            return Endpoints.parseBase + "/StudentLocation?limit=100&order=-updatedAt"
            
        case .postStudentLocation:
            return Endpoints.parseBase + "/StudentLocation"
            
        case .getUserInfo:
            return Endpoints.udacityBase + "/users/"
        }
    }
    
    var url: URL {
        return URL(string: stringValue)!
    }
}
