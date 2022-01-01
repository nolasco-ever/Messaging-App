//
//  ChatPage.swift
//  iPhone App
//
//  Created by Ever Nolasco on 12/31/21.
//

import UIKit
import FirebaseFirestore

class ChatPage: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var contactAvatarImageView: UIImageView!
    
    let db = Firestore.firestore()
    
    let contactID = ChatVariables.contactID
    let convoID = ChatVariables.convoID
    let contactName = ChatVariables.contactName
    let contactImage = ChatVariables.contactImage
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
           NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

        // Do any additional setup after loading the view.
        
        //round the textfield
        messageTextField.layer.cornerRadius = messageTextField.frame.height/2
        
        
        fullNameLabel.text = contactName
        contactAvatarImageView.image = contactImage
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
    
    @IBAction func sendMessage(_ sender: Any) {
        let message = messageTextField.text
        
        //send the message
        if let currentUserID = UserDefaults.standard.object(forKey: "user_uid_key") as? String {
            db.collection("conversations").document(convoID).collection("messages").addDocument(data: [
                "message": message!,
                "senderID": currentUserID])
            
            //set conversation boolean variable to true
            db.collection("users").document(currentUserID).collection("userContacts").document(contactID).updateData([
                "conversation": true])
        }
        
        messageTextField.resignFirstResponder()
        messageTextField.text = ""
    }
    
    @IBAction func goToSignup() {
        present(Functions.goToSignUpPage(storyboard: storyboard!), animated: true)
    }

    @IBAction func goToHomePage(_ sender: Any) {
        present(Functions.goToHomePage(storyboard: storyboard!), animated: true)
    }
}
