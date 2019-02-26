//
//  ViewController.swift
//  OnTheMap
//
//  Created by SDK on 1/24/19.
//  Copyright © 2019 SDK. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.isHidden = true
        emailTextField.text = "toxicajepu@netmails.info"
        passwordTextField.text = "Udacity@Test"
    }
    
    @IBAction func loginButtonClicked(_ sender: Any) {
        setLoggingIn(true)
        
        UdacityClient.login(username: emailTextField.text ?? "",
                            password: passwordTextField.text ?? "",
                            completion: handleLoginResponse(success:response:error:))
    }
}

// Mark - Private Functions

extension LoginViewController {
    
    private func setLoggingIn(_ loggingIn: Bool) {
        if loggingIn {
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
        }
        emailTextField.isEnabled = !loggingIn
        passwordTextField.isEnabled = !loggingIn
        loginButton.isEnabled = !loggingIn
    }
}

// Mark - Completion Handlers

extension LoginViewController {
    
    private func handleLoginResponse(success: Bool, response: SessionResponse?, error: Error?) {
        setLoggingIn(false)
        
        if success {
            if let response = response {
                Common.sharedInstance.userId = response.account.key
            }
            performSegue(withIdentifier: "loginSuccessful", sender: nil)
        } else {
            showError(withMessage: "Login failed. Check id/password")
        }
    }
}
