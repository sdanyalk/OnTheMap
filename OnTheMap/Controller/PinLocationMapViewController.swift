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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        initializeLinkTextField()
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        unsubscribeFromKeyboardNotifications()
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
        var studentLocation = StudentLocation()
        
        if let mediaUrl = linkTextField.text {
            studentLocation.mediaURL = mediaUrl
        } else {
            showError(withMessage: "Please enter URL")
        }

        studentLocation.uniqueKey = ""
        studentLocation.firstName = userInfo.firstName
        studentLocation.lastName = userInfo.lastName
        studentLocation.mapString = self.location
        studentLocation.latitude = studentCoordinate?.latitude
        studentLocation.longitude = studentCoordinate?.longitude

        ParseClient.postStudentLocation(body: studentLocation, completion: handlePostResponse(success:error:))
    }
    
    private func handlePostResponse(success: Bool, error: Error?) {
        if success {
            NotificationCenter.default.post(name: .reload, object: nil)
            self.navigationController?.popToRootViewController(animated: true)
        } else {
            showError(withMessage: "Unable to post location")
            
            if let error = error {
                print("Post location error: \(error)")
            }
        }
    }
}

// MARK: - Private Functions

extension PinLocationMapViewController {
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if linkTextField.isFirstResponder {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    @objc func keyboardWillHide(){
        view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue
        
        return keyboardSize.cgRectValue.height
    }
}

// MARK: - TextField Delegate

extension PinLocationMapViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        linkTextField.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        linkTextField.resignFirstResponder()
        
        return true
    }
    
    func initializeLinkTextField(){
        linkTextField.delegate = self
    }
}
