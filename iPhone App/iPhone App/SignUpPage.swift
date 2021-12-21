//
//  SignUpPage.swift
//  iPhone App
//
//  Created by Ever Nolasco on 12/20/21.
//

import UIKit

class SignUpPage: UIViewController {
    
    let radius = 10
    
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fullNameTextField.layer.cornerRadius = CGFloat(radius)
        usernameTextField.layer.cornerRadius = CGFloat(radius)
        passwordTextField.layer.cornerRadius = CGFloat(radius)
        signUpButton.layer.cornerRadius = CGFloat(radius)
    }

    @IBAction func goBack(_ sender: Any) {
        guard let loginVC = storyboard?.instantiateViewController(withIdentifier: "login_vc") as? LoginPage else { return }
        
        loginVC.modalPresentationStyle = .fullScreen
        
        present(loginVC, animated: true)
    }
}
