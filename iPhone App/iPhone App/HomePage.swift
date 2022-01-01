//
//  HomePage.swift
//  iPhone App
//
//  Created by Ever Nolasco on 12/21/21.
//

import UIKit
import FirebaseFirestore

class HomePage: UIViewController {
    
    @IBOutlet weak var userButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var conversationsTableView: UITableView!
    
    let db = Firestore.firestore()
    
    var conversations: [Conversation] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        conversationsTableView.delegate = self
        conversationsTableView.dataSource = self
        
        if let currentUserID = UserDefaults.standard.object(forKey: "user_uid_key") as? String {
            db.collection("users").document(currentUserID).collection("userContacts").getDocuments() { [self] (snapshot, err) in
                if let err = err {
                    print("ERROR GETTING DOCUMENTS: \(err)")
                } else {
                    for doc in snapshot!.documents {
                        let id = doc.get("id") as? String
                        let convoID = doc.get("convoID") as? String
                        var lastMessage: String = ""
                        
                        if (doc.get("conversation")! as! Bool == false){
                            lastMessage = "Tap here to start a conversation!"
                        }
                        else{
                            lastMessage = "Conversation exists!"
                        }
                        
                        db.collection("users").document(id!).getDocument { (document, err) in
                            if let document = document, document.exists {
                                let data = document.data()
                                
                                let name = data?["name"] ?? ""
                                let imageUrl = data?["image"] ?? ""
                                
                                let image = Functions.getImageFromUrl(from: imageUrl as! String)
                                
                                let conversation = Conversation(convoID: convoID!, id: id!, image: image, name: name as! String, lastMessage: lastMessage)
                                
                                conversations.append(conversation)
                                
                                let indexPath = IndexPath(row: conversations.count-1, section: 0)
                                conversationsTableView.insertRows(at: [indexPath], with: .automatic)
                            }
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func goToUserPage(_ sender: Any) {
        present(Functions.goToUserProfile(storyboard: storyboard!), animated: true)
    }
    
    @IBAction func goToSearchPage(_ sender: Any) {
        present(Functions.goToSearchPage(storyboard: storyboard!), animated: true)
    }
    
}

extension HomePage: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conversations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let conversation = conversations[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "conversation_cell") as! ConversationCell
        
        cell.setConversation(conversation: conversation)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let path = conversationsTableView.indexPathForSelectedRow
        
        let currentCell = conversationsTableView.cellForRow(at: path!)! as! ConversationCell
        
        let contactID = currentCell.contactID
        let convoID = currentCell.convoID
        let name = currentCell.userNameConversation.text
        let image = currentCell.userImageConversation.image
        
        ChatVariables.contactID = contactID
        ChatVariables.contactName = name!
        ChatVariables.contactImage = image
        ChatVariables.convoID = convoID
        
        
        
        present(Functions.goToChatPage(storyboard: storyboard!), animated: true)
    }
}
