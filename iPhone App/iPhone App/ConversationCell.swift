//
//  ConversationCell.swift
//  iPhone App
//
//  Created by Ever Nolasco on 12/28/21.
//

import UIKit

class ConversationCell: UITableViewCell {

    @IBOutlet weak var userImageConversation: UIImageView!
    @IBOutlet weak var userNameConversation: UILabel!
    @IBOutlet weak var lastMessageLabel: UILabel!
    
    var contactID: String = ""
    
    func setConversation(conversation: Conversation){
        contactID = conversation.id
        userImageConversation.image = conversation.image
        userNameConversation.text = conversation.name
        lastMessageLabel.text = conversation.lastMessage
    }
}
