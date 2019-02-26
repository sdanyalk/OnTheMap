//
//  PinLocationMapViewController.swift
//  OnTheMap
//
//  Created by SDK on 2/23/19.
//  Copyright © 2019 SDK. All rights reserved.
//

import UIKit
import MapKit

class PinLocationMapViewController: UIViewController, MKMapViewDelegate {
    
    // MARK: - Variables
    
    var studentCoordinate: CLLocationCoordinate2D?
    var location: String?
    var userInfo: UserInfoResponse = {
        return Common.sharedInstance.userInfo
    }()

    // MARK: - Outlets
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var linkTextField: UITextField!
    
    // MARK: - UIViewController lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        if let coordinate = studentCoordinate {
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            
            self.mapView.addAnnotation(annotation)
            let viewRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
            self.mapView.setRegion(viewRegion, animated: true)
        }
    }
    
    // MARK: - MKMapViewDelegate lifecycle

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }

    // MARK: - Actions

    @IBAction func submit(_ sender: Any) {
        print(userInfo)
        var studentLocation = StudentLocation()

        studentLocation.firstName = userInfo.firstName
        studentLocation.lastName = userInfo.lastName
        studentLocation.mapString = self.location
        studentLocation.mediaURL = ""
        studentLocation.latitude = studentCoordinate?.latitude
        studentLocation.longitude = studentCoordinate?.longitude
        
        ParseClient.postStudentLocation(body: studentLocation, completion: handlePostResponse(success:error:))
    }
    
    private func handlePostResponse(success: Bool, error: Error?) {
        
    }
}
