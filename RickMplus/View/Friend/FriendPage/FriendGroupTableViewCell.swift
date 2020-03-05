//
//  FriendGroupTableViewCell.swift
//  RickM+
//
//  Created by RickSun on 2020/2/1.
//  Copyright © 2020 RickSun. All rights reserved.
//

import UIKit

class FriendGroupTableViewCell: UITableViewCell {
    
    @IBOutlet weak var friendGroupImage: UIImageView!
    @IBOutlet weak var friendGroupName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        friendGroupImage.layer.masksToBounds = true
        friendGroupImage.layer.cornerRadius = 5
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
