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
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
           NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        fullNameTextField.layer.cornerRadius = CGFloat(radius)
        usernameTextField.layer.cornerRadius = CGFloat(radius)
        passwordTextField.layer.cornerRadius = CGFloat(radius)
        signUpButton.layer.cornerRadius = CGFloat(radius)
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
    
    @IBAction func createUser(_ sender: Any) {
        let name: String = fullNameTextField.text!
        let email: String = usernameTextField.text!
        let password: String = passwordTextField.text!
        
        signUp(name: name, email: email, password: password)
        
        //navigate to avatar selection page
        goToAvatarSelection()
    }
    
    @IBAction func goBack(_ sender: Any) {
        present(Functions.goToLogin(storyboard: storyboard!), animated: true)
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
            
            Functions.signIn(email: email, password: password, auth: auth)
        }
    }
    
    func goToAvatarSelection(){
        present(Functions.goToAvatarSelection(storyboard: storyboard!), animated: true)
    }
}
