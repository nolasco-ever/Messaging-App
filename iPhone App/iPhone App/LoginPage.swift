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
    
    @IBAction func goToSignup() {
        guard let signUpVC = storyboard?.instantiateViewController(withIdentifier: "sign_up_vc") as? SignUpPage else{
            return
        }
        
        signUpVC.modalPresentationStyle = .fullScreen
                
        present(signUpVC, animated: true)
    }
    
    @IBAction func loginUser() {
        let email: String = userTextField.text!
        let password: String = passwordTextField.text!
        
        signIn(email: email, password: password)
        
        goToHomePage()
    }
    
    func signIn(email: String, password: String){
        auth.signIn(withEmail: email, password: password){ [weak self] result, error in
            guard self != nil else { return }
            
            UserDefaults.standard.set(result?.user.uid, forKey: "user_uid_key")
            UserDefaults.standard.synchronize()
        }
    }
    
    func goToHomePage(){
        guard let homepageVC = storyboard?.instantiateViewController(withIdentifier: "avatar_selection") as? AvatarSelection else{ return }
        
        homepageVC.modalPresentationStyle = .fullScreen
        
        present(homepageVC, animated: true)
    }
}

