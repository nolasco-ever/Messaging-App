//
//  SearchPage.swift
//  iPhone App
//
//  Created by Ever Nolasco on 12/24/21.
//

import UIKit

class SearchPage: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    
    let radius = 10

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextField.layer.cornerRadius = CGFloat(radius)

        // Do any additional setup after loading the view.
    }

}
