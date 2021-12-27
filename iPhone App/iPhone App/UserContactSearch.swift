//
//  UserContactSearch.swift
//  iPhone App
//
//  Created by Ever Nolasco on 12/26/21.
//

import Foundation
import UIKit

class UserContactSearch {
    var id: String
    var image: UIImage
    var name: String
    var email: String
    
    init(id: String, image: UIImage, name: String, email: String){
        self.id = id
        self.image = image
        self.name = name
        self.email = email
    }
}
