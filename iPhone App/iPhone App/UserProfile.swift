//
//  UserProfile.swift
//  iPhone App
//
//  Created by Ever Nolasco on 12/26/21.
//

import UIKit
import FirebaseFirestore
import Firebase

class UserProfile: UIViewController {
    
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var fullNameTextView: UILabel!
    @IBOutlet weak var emailTextView: UILabel!
    @IBOutlet weak var signOutButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var editProfilePictureButton: UIButton!
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let currentUserID = UserDefaults.standard.object(forKey: "user_uid_key") as? String {
            db.collection("users").document(currentUserID).getDocument { [self] (doc, err) in
                if let doc = doc, doc.exists {
                    let data = doc.data()
                    
                    let name = data?["name"] ?? ""
                    let email = data?["email"] ?? ""
                    let imageUrl = data?["image"] ?? ""
                    
                    let image = Functions.getImageFromUrl(from: imageUrl as! String)
                    
                    fullNameTextView.text = name as? String
                    emailTextView.text = email as? String
                    profilePicture.image = image
                } else {
                    print("NO DOCUMENT FOUND")
                }
            }
        }

        // Do any additional setup after loading the view.
    }
    
    @IBAction func goToAvatarSelection(_ sender: Any) {
        //navigate to avatar selection page
        present(Functions.goToAvatarSelection(storyboard: storyboard!), animated: true)
    }
    
    @IBAction func signOut(_ sender: Any) {
        let auth = Auth.auth()
        
        do {
            try auth.signOut()
        } catch let err as NSError {
            print("Error signing out: \(err)")
        }
        
        Functions.setUserDefaultsUID(id: nil)
        
        //go to login page
        present(Functions.goToLogin(storyboard: storyboard!), animated: true)
    }
    
    @IBAction func backToHome(_ sender: Any) {
        //navigate to homepage
        present(Functions.goToHomePage(storyboard: storyboard!), animated: true)
    }

}
