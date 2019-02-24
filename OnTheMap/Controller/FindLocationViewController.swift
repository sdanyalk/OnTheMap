//
//  PinLocationViewController.swift
//  OnTheMap
//
//  Created by SDK on 2/23/19.
//  Copyright © 2019 SDK. All rights reserved.
//

import UIKit
import CoreLocation

class FindLocationViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var findButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: Variables
    lazy var geocoder = CLGeocoder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    
    @IBAction func findOnMap(_ sender: Any) {
        let location = locationTextField.text!
        
        if location.isEmpty {
            showError(withMessage: "Location is required")
            return
        }
    }
}

extension FindLocationViewController {
    
    // MARK: - Private Functions
    
    
}
