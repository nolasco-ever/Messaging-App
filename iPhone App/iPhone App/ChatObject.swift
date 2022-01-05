//
//  ChatObject.swift
//  iPhone App
//
//  Created by Ever Nolasco on 1/4/22.
//

import Foundation
import UIKit

class ChatObject {
    var id: String
    var image: UIImage
    var message: String
    
    init(id: String, image: UIImage, message: String){
        self.id = id
        self.image = image
        self.message = message
    }
}
