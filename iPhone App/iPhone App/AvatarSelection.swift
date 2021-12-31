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
    
    //initialize empty array
    var avatarArray: [String] = []
    
    //variable to hold selected cell
    var selectedCell: Int = 0
    
    var selectedAvatarLink: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        avatarCollectionView.delegate = self
        avatarCollectionView.dataSource = self
        
        //retrieve all avatar image links from firestore database
        db.collection("avatars").getDocuments() { [self] (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            }
            else{
                //append all avatar links to avatarArray
                for doc in querySnapshot!.documents{
                    let link = doc.get("link") as! String
                    avatarArray.append(link)
                    
                    let indexPath = IndexPath(row: avatarArray.count-1, section: 0)
                    avatarCollectionView.insertItems(at: [indexPath])
                }
            }
        }
        
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
        return avatarArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = avatarCollectionView.dequeueReusableCell(withReuseIdentifier: AvatarCell.identifier, for: indexPath) as! AvatarCell
        
        cell.avatarImageView.image = Functions.getImageFromUrl(from: avatarArray[indexPath.row])
        
        //make sure image is round
        cell.layer.cornerRadius = cell.frame.height / 2
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell: UICollectionViewCell = avatarCollectionView.cellForItem(at: indexPath)!

        cell.layer.borderWidth = 5
        cell.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        
        selectedCell = indexPath.row
        selectedAvatarLink = avatarArray[selectedCell]
        
        print(avatarArray[indexPath.row])
    }
    
}
