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
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
    @IBAction func loginButtonClicked(_ sender: Any) {
        setLoggingIn(true)
        
        UdacityClient.login(username: emailTextField.text ?? "", password: passwordTextField.text ?? "", completion: handleLoginResponse(success:error:))
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
    
    private func showLoginFailure(message: String) {
        let alertVC = UIAlertController(title: "Login Failed", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        show(alertVC, sender: nil)
    }
}

// Mark - Completion Handlers
extension LoginViewController {
    
    private func handleLoginResponse(success: Bool, error: Error?) {
        setLoggingIn(false)
        
        if success {
            print("Successful login")
            //segue to other screen
        } else {
            showLoginFailure(message: error?.localizedDescription ?? "")
        }
    }
}
