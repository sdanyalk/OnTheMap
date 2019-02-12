//
//  LocationResultResponse.swift
//  OnTheMap
//
//  Created by SDK on 2/12/19.
//  Copyright © 2019 SDK. All rights reserved.
//

import Foundation

struct LocationResult: Codable {
    
    let results: [StudentLocation]
    
    enum CodingKeys: String, CodingKey {
        case results
    }
}
