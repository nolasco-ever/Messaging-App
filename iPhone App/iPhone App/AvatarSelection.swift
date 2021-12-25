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
    
    //create firestore database variable
    let db = Firestore.firestore()
    
    //initialize empty array
    var avatarArray: [String] = []
    
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
                    print("DOCUMENT RESULT: \(link)")
                    avatarArray.append(link)
                }
                
                print("AVATAR ARRAY: \(avatarArray)")
            }
        }
        
    }
    
//    func createAvatarArray() -> [String]{
//        var tempArray: [String] = []
//
//        return db.collection("avatars").getDocuments() { [self] (querySnapshot, err) in
//            if let err = err {
//                print("Error getting documents: \(err)")
//            }
//            else{
//                //append all avatar links to avatarArray
//                for doc in querySnapshot!.documents{
//                    let link = doc.get("link") as! String
//                    print("DOCUMENT RESULT: \(link)")
//                    tempArray.append(link)
//                }
//
//                return tempArray
//            }
//        }
//    }

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
        
        cell.avatarImageView.image = getImageFromUrl(from: avatarArray[indexPath.row])
        
        //make sure image is round
        cell.layer.cornerRadius = cell.frame.height / 2
        
        return cell
    }
    
    func getImageFromUrl(from url: String) -> UIImage{
        let imageURL = URL(string: url)
        
        //avoid causing a deadlock in the UI
        let imageData = try? Data(contentsOf: imageURL!)
        
        let image = UIImage(data: imageData!)!
        
        return image
    }
    
}
