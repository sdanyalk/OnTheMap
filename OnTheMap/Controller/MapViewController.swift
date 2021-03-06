//
//  MapViewController.swift
//  OnTheMap
//
//  Created by SDK on 2/11/19.
//  Copyright © 2019 SDK. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData), name: .reload, object: nil)
        
        showStudents()
        loadUserInfo()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
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
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            let app = UIApplication.shared
            if let toOpen = view.annotation?.subtitle! {
                app.open(URL(string: toOpen)!, options: [:], completionHandler: nil)
            }
        }
    }
    
    @IBAction func addLocation(_ sender: Any) {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "FindLocationViewController") as! FindLocationViewController
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func logout(_ sender: Any) {
        UdacityClient.logout(completion: handleLogoutResponse(response:error:))
    }
}

extension MapViewController {
    
    private func handleLogoutResponse(response: SessionDeleteResponse?, error: Error?) {
        if let error = error {
            showError(withMessage: error.localizedDescription)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
}

// MARK : - Private Functions

extension MapViewController {
    
    func showStudents() {
        var annotations = [MKPointAnnotation]()
        
        ParseClient.getStudentLocation() { locations, error in
            if let error = error {
                self.showError(withMessage: error.localizedDescription)
                
                return
            }
            
            for location in locations {
                guard
                    let lat: Double = location.latitude,
                    let long: Double = location.longitude,
                    let firstName: String = location.firstName,
                    let lastName: String = location.lastName,
                    let mediaURL: String = location.mediaURL else {
                        
                        debugPrint("ERROR: one of the properties needed for annotation is empty")
                        continue
                }
                Common.sharedInstance.studentLocation.append(location)
                
                let latitude = CLLocationDegrees(lat)
                let longitude = CLLocationDegrees(long)
                
                let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinate
                annotation.title = "\(firstName) \(lastName)"
                annotation.subtitle = mediaURL
                
                annotations.append(annotation)
            }
            
            self.mapView.addAnnotations(annotations)
            self.mapView.showAnnotations(self.mapView.annotations, animated: true)
        }
    }
    
    func loadUserInfo(){
        UdacityClient.getUserInfo(id: Common.sharedInstance.userId) { userInfoResponse, error in
            if let error = error {
                self.showError(withMessage: error.localizedDescription)
                
                return
            }
            
            if let userInfoResponse = userInfoResponse {
                Common.sharedInstance.userInfo = userInfoResponse
            }
        }
    }
    
    @objc func reloadData() {
        self.showStudents()
    }
}
