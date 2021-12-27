//
//  SignUpPage.swift
//  iPhone App
//
//  Created by Ever Nolasco on 12/20/21.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

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
        
        //navigate to avatar selection page
        guard let avatarSelectionVC = storyboard?.instantiateViewController(withIdentifier: "avatar_selection") as? AvatarSelection else { return }
        
        avatarSelectionVC.modalPresentationStyle = .fullScreen
        
        present(avatarSelectionVC, animated: true)
    }
    
    @IBAction func goBack(_ sender: Any) {
        guard let loginVC = storyboard?.instantiateViewController(withIdentifier: "login_vc") as? LoginPage else { return }
        
        loginVC.modalPresentationStyle = .fullScreen
        
        present(loginVC, animated: true)
    }
    
    func signUp(name: String, email: String, password: String){
        auth.createUser(withEmail: email, password: password){ [self] result, error in
            guard result != nil, error == nil else{
                print("SIGN UP RESULT: \(String(describing: error))")
                return
            }
            
//            Success
            let db = Firestore.firestore()
            let id = result!.user.uid
            
            db.collection("users").document(id).setData([
                "id": id,
                "name": name,
                "email": email])
            
            signIn(email: email, password: password)
        }
    }
    
    func signIn(email: String, password: String){
        auth.signIn(withEmail: email, password: password){ [weak self] result, error in
            guard self != nil else { return }
            
            UserDefaults.standard.set(result?.user.uid, forKey: "user_uid_key")
            UserDefaults.standard.synchronize()
        }
    }
}
