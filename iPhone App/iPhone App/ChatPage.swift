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
    @IBOutlet weak var conversationTableView: UITableView!
    
    let db = Firestore.firestore()
    
    //variables to be used
    let contactID = ChatVariables.contactID
    let convoID = ChatVariables.convoID
    let contactName = ChatVariables.contactName
    let contactImage = ChatVariables.contactImage
    
    var chatMessages: [ChatObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        conversationTableView.delegate = self
        conversationTableView.dataSource = self
        
        //reverse the table view
        conversationTableView.transform = CGAffineTransform (scaleX: 1, y: -1);
        
        //remove border from tableview cells
        conversationTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        conversationTableView.estimatedRowHeight = 100.0
        conversationTableView.rowHeight = UITableView.automaticDimension
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
           NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

        // Do any additional setup after loading the view.
        
        //round the textfield
        messageTextField.layer.cornerRadius = messageTextField.frame.height/2
        messageTextField.setLeftPaddingPoints(10)
        
        //set placeholder color
        Functions.setPlaceholderColor(textField: messageTextField)
        
        
        fullNameLabel.text = contactName
        contactAvatarImageView.image = contactImage
        
        //get messages
        db.collection("conversations").document(convoID).collection("messages").order(by: "timestamp", descending: true).addSnapshotListener { [self] querySnapshot, err in
            
            //variable to hold document
            guard let documents = querySnapshot?.documents else {
                print("Error fetching documents: \(err!)")
                return
            }
            
            //snapshot variable
            guard let snapshot = querySnapshot else {
                print("Error fetching snapshots: \(err!)")
                return
            }
            
            //check for changes in snapshot query
            snapshot.documentChanges.forEach { diff in
                if (diff.type == .added) {
                    print("MESSAGE ADDED")
                    chatMessages.removeAll()
                    conversationTableView.reloadData()
                }
            }
            
            //map through all the documents and get required data
            documents.map {
                let senderID = $0["senderID"] ?? ""
                let message = $0["message"] ?? ""
                
                let chatMessageObject = ChatObject(id: senderID as! String, image: contactImage!, message: message as! String)
                
                chatMessages.append(chatMessageObject)
                
                let indexPath = IndexPath(row: chatMessages.count-1, section: 0)
                
                conversationTableView.insertRows(at: [indexPath], with: .automatic)
            }
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
    
    @IBAction func sendMessage(_ sender: Any) {
        let message = messageTextField.text
        
        //send the message
        if let currentUserID = UserDefaults.standard.object(forKey: "user_uid_key") as? String {
            let timestamp = Date().currentTimeMillis()
            
            db.collection("conversations").document(convoID).collection("messages").addDocument(data: [
                "message": message!,
                "senderID": currentUserID,
                "timestamp": timestamp])
            
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

extension ChatPage: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatMessages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let chatMessage = chatMessages[indexPath.row]
        let cell = UITableViewCell()
        
        if let currentUserID = UserDefaults.standard.object(forKey: "user_uid_key") as? String {
            if (chatMessage.id == contactID){
                let cell = tableView.dequeueReusableCell(withIdentifier: "grey_chat_bubble") as! GreyChatBubble
                
                cell.setMessage(chatMessage: chatMessage)
                
                //reverse the cell
                cell.contentView.transform = CGAffineTransform(scaleX: 1, y: -1)
                
                cell.selectionStyle = UITableViewCell.SelectionStyle.none
                
                return cell
            }
            else if (chatMessage.id == currentUserID){
                let cell = tableView.dequeueReusableCell(withIdentifier: "blue_chat_bubble") as! BlueChatBubble
                
                cell.setMessage(chatMessage: chatMessage)
                
                //reverse the cell
                cell.contentView.transform = CGAffineTransform(scaleX: 1, y: -1)
                
                cell.selectionStyle = UITableViewCell.SelectionStyle.none
                
                return cell
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension Date {
    func currentTimeMillis() -> Int64 {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}

// Put this piece of code anywhere you like
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
