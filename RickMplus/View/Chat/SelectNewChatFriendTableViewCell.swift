//
//  SelectNewChatFriendTableViewCell.swift
//  RickM+
//
//  Created by RickSun on 2020/2/19.
//  Copyright © 2020 RickSun. All rights reserved.
//

import UIKit

class SelectNewChatFriendTableViewCell: UITableViewCell {
    @IBOutlet weak var selectChatFriendImage: UIImageView!
    
    @IBOutlet weak var selectChatFriendNameLabel: UILabel!
    
    @IBOutlet weak var selectChatFriendStatusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
