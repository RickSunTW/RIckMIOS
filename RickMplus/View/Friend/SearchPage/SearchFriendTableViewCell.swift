//
//  SearchFriendTableViewCell.swift
//  RickM+
//
//  Created by RickSun on 2020/2/1.
//  Copyright © 2020 RickSun. All rights reserved.
//

import UIKit

class SearchFriendTableViewCell: UITableViewCell {
    @IBOutlet weak var searchFriendImage: UIImageView!
    @IBOutlet weak var searchFriendName: UILabel!
    @IBOutlet weak var confirmFriendStatusBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        confirmFriendStatusBtn.setTitle("加入好友", for: .normal)
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
        // Configure the view for the selected state
    }
    
}
