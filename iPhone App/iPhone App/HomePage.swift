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
    
    
    let db = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func goToUserPage(_ sender: Any) {
        guard let userPageVC = storyboard?.instantiateViewController(withIdentifier: "user_profile_vc") as? UserProfile else { return }
        
        userPageVC.modalPresentationStyle = .fullScreen
        
        present(userPageVC, animated: true)
    }
    
    @IBAction func goToSearchPage(_ sender: Any) {
        guard let searchPageVC = storyboard?.instantiateViewController(withIdentifier: "search_page_vc") as? SearchPage else { return }
        
        searchPageVC.modalPresentationStyle = .fullScreen
        
        present(searchPageVC, animated: true)
    }
    
}
