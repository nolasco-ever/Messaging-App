//
//  GreyChatBubble.swift
//  iPhone App
//
//  Created by Ever Nolasco on 1/4/22.
//

import UIKit

class GreyChatBubble: UITableViewCell {

    @IBOutlet weak var contactImageView: UIImageView!
    @IBOutlet weak var contactMessageLabel: UILabel!
    
    let radius = 15
    
    func setMessage(chatMessage: ChatObject){
        contactImageView.image = chatMessage.image
        contactMessageLabel.text = chatMessage.message
        
        contactMessageLabel.layer.masksToBounds = true
        contactMessageLabel.layer.cornerRadius = CGFloat(radius)
        
        //account for height when the text length is too big
        contactMessageLabel.numberOfLines = 0
        contactMessageLabel.sizeToFit()
    }

}
