//
//  Common.swift
//  OnTheMap
//
//  Created by SDK on 2/13/19.
//  Copyright © 2019 SDK. All rights reserved.
//

import Foundation

class Common {
    
    static let sharedInstance = Common()
    
    var studentLocation = [StudentLocation]()
    var userId = String()
    var userInfo = UserInfoResponse(name: "", firstName: "", lastName: "")
}
