//
//  ViewController.swift
//  iPhone App
//
//  Created by Ever Nolasco on 12/20/21.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class LoginPage: UIViewController {
    let auth = Auth.auth()
    
    let radius = 10

    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
           NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        userTextField.layer.cornerRadius = CGFloat(radius)
        passwordTextField.layer.cornerRadius = CGFloat(radius)
        loginButton.layer.cornerRadius = CGFloat(radius)
        signUpButton.layer.cornerRadius = CGFloat(radius)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {

        super.viewDidAppear(animated)

        // Check if the user is logged in
        if UserDefaults.standard.object(forKey: "user_uid_key") != nil {
            // send them to a new view controller or do whatever you want
            goToHomePage()
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    @IBAction func goToSignup() {
        present(Functions.goToSignUpPage(storyboard: storyboard!), animated: true)
    }
    
    @IBAction func loginUser() {
        let email: String = userTextField.text!
        let password: String = passwordTextField.text!
        
        Functions.signIn(email: email, password: password, auth: auth)
        
        goToHomePage()
    }
    
    func goToHomePage(){
        present(Functions.goToHomePage(storyboard: storyboard!), animated: true)
    }
}

