//
//  FriendGroupTableViewCell.swift
//  RickM+
//
//  Created by RickSun on 2020/1/30.
//  Copyright © 2020 RickSun. All rights reserved.
//

import UIKit

class FriendCompanyGroupTableViewCell: UITableViewCell {
    @IBOutlet weak var friendCompanyGroupImage: UIImageView!
    @IBOutlet weak var friendCompanyGroupIconImage: UIImageView!
    @IBOutlet weak var friendCompanyGroupName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        friendCompanyGroupImage.layer.masksToBounds = true
        friendCompanyGroupImage.layer.cornerRadius = 5
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
