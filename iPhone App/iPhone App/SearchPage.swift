//
//  SearchPage.swift
//  iPhone App
//
//  Created by Ever Nolasco on 12/24/21.
//

import UIKit
import FirebaseFirestore

class SearchPage: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchResultsTableView: UITableView!
    @IBOutlet weak var showingResultsLabel: UILabel!
    
    let radius = 10
    let db = Firestore.firestore()
    var users: [UserContactSearch] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        searchResultsTableView.delegate = self
        searchResultsTableView.dataSource = self
        
        searchTextField.delegate = self
        
        searchTextField.layer.cornerRadius = CGFloat(radius)
        
        Functions.setPlaceholderColor(textField: searchTextField)
        
        //label needs to be blank when no query has been made
        showingResultsLabel.text = ""

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backToHome(_ sender: Any) {
        present(Functions.goToHomePage(storyboard: storyboard!), animated: true)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("return pressed")
        searchTextField.resignFirstResponder()
        performAction()
        return true
    }
    
    func performAction() {
        //action events
        
        let query = searchTextField.text
        
        db.collection("users").getDocuments() { [self] (snapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for doc in snapshot!.documents {
                    let name = doc.get("name") as? String
                    
                    if name!.contains(query!){
                        let imageURL = doc.get("image") as? String
                        
                        let id = doc.get("id") as? String
                        let image = Functions.getImageFromUrl(from: imageURL!)
                        let email = doc.get("email") as? String
                        
                        let user = UserContactSearch(id: id!, image: image, name: name!, email: email!)
                        
                        users.append(user)
                        
                        let indexPath = IndexPath(row: users.count-1, section: 0)
                        searchResultsTableView.insertRows(at: [indexPath], with: .automatic)
                    }
                }
            }
        }
        
        showingResultsLabel.text = "Showing results for: '\(query ?? "")'"
    }

}

extension SearchPage: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = users[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "user_search_cell") as! UserSearchCell
        
        cell.setUser(user: user)
        
        return cell
    }
    
    
}
