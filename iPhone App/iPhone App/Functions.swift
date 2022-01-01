//
//  Functions.swift
//  iPhone App
//
//  Created by Ever Nolasco on 12/31/21.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseFirestore

class Functions {
    //function to convert url to an image
    static func getImageFromUrl(from url: String) -> UIImage{
        let imageURL = URL(string: url)
        
        //avoid causing a deadlock in the UI
        let imageData = try? Data(contentsOf: imageURL!)
        
        let image = UIImage(data: imageData!)!
        
        return image
    }
    
    //function that signs the user into the app
    static func signIn(email: String, password: String, auth: Auth){
        auth.signIn(withEmail: email, password: password){ result, error in
            let id = result?.user.uid
            
            setUserDefaultsUID(id: id!)
        }
    }
    
    //set the user default id
    static func setUserDefaultsUID(id: String?){
        UserDefaults.standard.set(id, forKey: "user_uid_key")
        UserDefaults.standard.synchronize()
    }
    
    //function that returns a view controller
    static func createViewController(identifier: String, storyboard: UIStoryboard) -> UIViewController{
        //navigate to avatar selection page
        let viewController = storyboard.instantiateViewController(withIdentifier: identifier)
        
        viewController.modalPresentationStyle = .fullScreen
        
        return viewController
    }
    
    //functions that navigate the user to specified page
    static func goToHomePage(storyboard: UIStoryboard) -> UIViewController{
        return createViewController(identifier: "homepage_vc", storyboard: storyboard)
    }
    
    static func goToChatPage(storyboard: UIStoryboard) -> UIViewController{
        return createViewController(identifier: "chat_page_vc", storyboard: storyboard)
    }
    
    static func goToAvatarSelection(storyboard: UIStoryboard) -> UIViewController{
        return createViewController(identifier: "avatar_selection", storyboard: storyboard)
    }
    
    static func goToLogin(storyboard: UIStoryboard) -> UIViewController{
        return createViewController(identifier: "login_vc", storyboard: storyboard)
    }
    
    static func goToUserProfile(storyboard: UIStoryboard) -> UIViewController{
        return createViewController(identifier: "user_profile_vc", storyboard: storyboard)
    }
    
    static func goToSearchPage(storyboard: UIStoryboard) -> UIViewController{
        return createViewController(identifier: "search_page_vc", storyboard: storyboard)
    }
    
    static func goToSignUpPage(storyboard: UIStoryboard) -> UIViewController{
        return createViewController(identifier: "sign_up_vc", storyboard: storyboard)
    }
}
