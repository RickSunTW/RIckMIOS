//
//  FriendPersonalTableViewCell.swift
//  RickM+
//
//  Created by RickSun on 2020/1/30.
//  Copyright © 2020 RickSun. All rights reserved.
//

import UIKit

class FriendPersonalTableViewCell: UITableViewCell {
    @IBOutlet weak var friendPersonalImage: UIImageView!
    @IBOutlet weak var friendPersonalName: UILabel!
    @IBOutlet weak var friendPersonalStatus: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        friendPersonalImage.layer.masksToBounds = true
        friendPersonalImage.layer.cornerRadius = 5
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
