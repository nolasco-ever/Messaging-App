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
                    
                    let image = getImageFromUrl(from: imageUrl as! String)
                    
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
        guard let avatarSelectionVC = storyboard?.instantiateViewController(withIdentifier: "avatar_selection") as? AvatarSelection else { return }

        avatarSelectionVC.modalPresentationStyle = .fullScreen

        present(avatarSelectionVC, animated: true)
    }
    
    @IBAction func signOut(_ sender: Any) {
        let auth = Auth.auth()
        
        do {
            try auth.signOut()
        } catch let err as NSError {
            print("Error signing out: \(err)")
        }
        
        UserDefaults.standard.set(nil, forKey: "user_uid_key")
        UserDefaults.standard.synchronize()
        
        //go to login pagge
        guard let loginPageVC = storyboard?.instantiateViewController(withIdentifier: "login_vc") as? LoginPage else { return }
        
        loginPageVC.modalPresentationStyle = .fullScreen
        
        present(loginPageVC, animated: true)
    }
    
    @IBAction func backToHome(_ sender: Any) {
        //navigate to homepage
        guard let homepageVC = storyboard?.instantiateViewController(withIdentifier: "homepage_vc") as? HomePage else { return }
        
        homepageVC.modalPresentationStyle = .fullScreen
        
        present(homepageVC, animated: true)
    }
    
    func getImageFromUrl(from url: String) -> UIImage{
        let imageURL = URL(string: url)
        
        //avoid causing a deadlock in the UI
        let imageData = try? Data(contentsOf: imageURL!)
        
        let image = UIImage(data: imageData!)!
        
        return image
    }

}
