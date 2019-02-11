//
//  ErrorResponse.swift
//  OnTheMap
//
//  Created by SDK on 2/10/19.
//  Copyright © 2019 SDK. All rights reserved.
//

import Foundation

struct ErrorResponse: Codable {
    let status: Int
    let error: String
    
    enum CodingKeys: String, CodingKey {
        case status
        case error
    }
}

extension ErrorResponse: LocalizedError {
    var errorDescription: String? {
        return error
    }
}
