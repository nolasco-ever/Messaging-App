//
//  ViewController.swift
//  iPhone App
//
//  Created by Ever Nolasco on 12/20/21.
//

import UIKit

class LoginPage: UIViewController {
    
    let radius = 10

    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userTextField.layer.cornerRadius = CGFloat(radius)
        passwordTextField.layer.cornerRadius = CGFloat(radius)
        loginButton.layer.cornerRadius = CGFloat(radius)
        signUpButton.layer.cornerRadius = CGFloat(radius)
        
    }
    
    @IBAction func goToSignup() {
        guard let signUpVC = storyboard?.instantiateViewController(withIdentifier: "sign_up_vc") as? SignUpPage else{
            return
        }
        
        signUpVC.modalPresentationStyle = .fullScreen
                
        present(signUpVC, animated: true)
    }
    
}

