//
//  SignUpPage.swift
//  iPhone App
//
//  Created by Ever Nolasco on 12/20/21.
//

import UIKit
import FirebaseAuth

class SignUpPage: UIViewController {
    let auth = Auth.auth()
    
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
    
    @IBAction func createUser(_ sender: Any) {
        let name: String = fullNameTextField.text!
        let email: String = usernameTextField.text!
        let password: String = passwordTextField.text!
        
        signUp(name: name, email: email, password: password)
        
        
    }
    
    @IBAction func goBack(_ sender: Any) {
        guard let loginVC = storyboard?.instantiateViewController(withIdentifier: "login_vc") as? LoginPage else { return }
        
        loginVC.modalPresentationStyle = .fullScreen
        
        present(loginVC, animated: true)
    }
    
    func signUp(name: String, email: String, password: String){
        auth.createUser(withEmail: email, password: password){ result, error in
            guard result != nil, error == nil else{
                return
            }
            
//            Success
        }
    }
}
