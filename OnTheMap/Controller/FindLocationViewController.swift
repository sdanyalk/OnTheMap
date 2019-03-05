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
    var coordinate: CLLocationCoordinate2D?
    
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
        
        geocode(location: location)
    }
}

// Mark - Private Functions

extension FindLocationViewController {
    
    private func geocode(location: String) {
        activityIndicator.startAnimating()
        
        geocoder.geocodeAddressString(location) { (placemarks, error) in
            self.performUIUpdatesOnMain {
                self.activityIndicator.stopAnimating()
            }
            
            if let error = error {
                self.showError(withMessage: "Error with geo location: (\(error))")
            } else {
                var location: CLLocation?
                
                if let placemarks = placemarks, placemarks.count > 0 {
                    location = placemarks.first?.location
                }
                
                if let location = location {
                    self.coordinate = location.coordinate
                    
                    let viewController = self.storyboard?.instantiateViewController(withIdentifier: "PinLocationMapViewController") as! PinLocationMapViewController
                    viewController.studentCoordinate = self.coordinate
                    viewController.location = self.locationTextField.text
                    self.navigationController?.pushViewController(viewController, animated: true)
                } else {
                    self.showError(withMessage: "No matching location found")
                }
            }
        }
    }
}
