//
//  ViewController.swift
//  iPhone App
//
//  Created by Ever Nolasco on 12/20/21.
//

import UIKit

class ViewController: UIViewController {
    
    let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
    
    let radius = 10

    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userTextField.layer.cornerRadius = CGFloat(radius)
        
        passwordTextField.layer.cornerRadius = CGFloat(radius)
        passwordTextField.layer.bounds.inset(by: padding)
        
        loginButton.layer.cornerRadius = CGFloat(radius)
        signUpButton.layer.cornerRadius = CGFloat(radius)
    }


}

