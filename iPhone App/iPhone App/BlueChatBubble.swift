//
//  BlueChatBubble.swift
//  iPhone App
//
//  Created by Ever Nolasco on 1/4/22.
//

import UIKit

class BlueChatBubble: UITableViewCell {

    @IBOutlet weak var userMessageLabel: UILabel!
    
    let radius = 15
    
    func setMessage(chatMessage: ChatObject){
        userMessageLabel.text = chatMessage.message
        
        userMessageLabel.layer.masksToBounds = true
        userMessageLabel.layer.cornerRadius = CGFloat(radius)
        
        //account for height when the text length is too big
        userMessageLabel.numberOfLines = 0
        userMessageLabel.sizeToFit()
    }
}
