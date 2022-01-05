//
//  AvatarSelection.swift
//  iPhone App
//
//  Created by Ever Nolasco on 12/21/21.
//

import UIKit
import FirebaseFirestore

class AvatarSelection: UIViewController {

    @IBOutlet weak var avatarCollectionView: UICollectionView!
    
    @IBOutlet weak var finishButton: UIButton!
    
    //create firestore database variable
    let db = Firestore.firestore()
    
    //variable to hold selected cell
    var selectedCell: Int = 0
    
    var selectedAvatarLink: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        avatarCollectionView.delegate = self
        avatarCollectionView.dataSource = self
        
    }
    
    @IBAction func setAvatar(_ sender: Any) {
        if let currentUserID = UserDefaults.standard.object(forKey: "user_uid_key") as? String {
            db.collection("users").document(currentUserID).setData([
                "image": selectedAvatarLink
            ], merge: true)
        }
        
        //navigate to homepage
        present(Functions.goToHomePage(storyboard: storyboard!), animated: true)
    }
    

}

extension AvatarSelection: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ThisAppData.avatars.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = avatarCollectionView.dequeueReusableCell(withReuseIdentifier: AvatarCell.identifier, for: indexPath) as! AvatarCell
        
        cell.avatarImageView.image = Functions.getImageFromUrl(from: ThisAppData.avatars[indexPath.row])
        
        //make sure image is round
        cell.layer.cornerRadius = cell.frame.height / 2
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell: UICollectionViewCell = avatarCollectionView.cellForItem(at: indexPath)!

        cell.layer.borderWidth = 5
        cell.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        
        selectedCell = indexPath.row
        selectedAvatarLink = ThisAppData.avatars[selectedCell]
    }
    
}
