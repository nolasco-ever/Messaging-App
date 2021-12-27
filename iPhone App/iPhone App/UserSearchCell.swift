//
//  UserSearchCell.swift
//  iPhone App
//
//  Created by Ever Nolasco on 12/26/21.
//

import UIKit
import FirebaseFirestore

class UserSearchCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    
    var id: String = ""
    
    let db = Firestore.firestore()
    
    func setUser(user: UserContactSearch){
        id = user.id
        userImageView.image = user.image
        userNameLabel.text = user.name
        userEmailLabel.text = user.email
        
        setAddButton(id: id)
    }
    
    func setAddButton(id: String) {
        if let currentUserID = UserDefaults.standard.object(forKey: "user_uid_key") as? String {
            db.collection("users").document(currentUserID).collection("userContacts").whereField("id", isEqualTo: id).getDocuments { [self] (snapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    let count: Int = snapshot!.count
                    
                    if (count != 0) {
                        addButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
                    }
                    else {
                        addButton.setImage(UIImage(systemName: "plus"), for: .normal)
                    }
                }
            }
        }
    }
    
    @IBAction func addUser(_ sender: Any) {
        addButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
        
        let id = self.id
        let name = userNameLabel.text
        let email = userEmailLabel.text
        
        if let currentUserID = UserDefaults.standard.object(forKey: "user_uid_key") as? String {
            db.collection("users").document(currentUserID).collection("userContacts").document(self.id).setData([
                "id": id,
                "name": name!,
                "email": email!])
        }
    }
    
}
