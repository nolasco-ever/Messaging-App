//
//  Conversation.swift
//  iPhone App
//
//  Created by Ever Nolasco on 12/28/21.
//

import Foundation
import UIKit

class Conversation {
    var id: String
    var image: UIImage
    var name: String
    var lastMessage: String
    
    init(id: String, image: UIImage, name: String, lastMessage: String){
        self.id = id
        self.image = image
        self.name = name
        self.lastMessage = lastMessage
    }
}
