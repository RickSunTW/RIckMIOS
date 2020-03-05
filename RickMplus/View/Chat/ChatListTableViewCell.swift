//
//  ChatListTableViewCell.swift
//  RickM+
//
//  Created by RickSun on 2020/2/3.
//  Copyright © 2020 RickSun. All rights reserved.
//

import UIKit

class ChatListTableViewCell: UITableViewCell {

    @IBOutlet weak var chatListImage: UIImageView!
    @IBOutlet weak var chatListCompanyImage: UIImageView!
    @IBOutlet weak var chatListName: UILabel!
    @IBOutlet weak var chatListLastChat: UILabel!
    @IBOutlet weak var chatListLastDay: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


