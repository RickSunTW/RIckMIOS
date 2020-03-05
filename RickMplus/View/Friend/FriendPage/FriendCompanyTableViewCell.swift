//
//  FriendCompanyTableViewCell.swift
//  RickM+
//
//  Created by RickSun on 2020/1/30.
//  Copyright © 2020 RickSun. All rights reserved.
//

import UIKit

class FriendCompanyTableViewCell: UITableViewCell {

    @IBOutlet weak var friendCompanyImage: UIImageView!
    @IBOutlet weak var friendCompanyIconImage: UIImageView!
    @IBOutlet weak var friendCompanyName: UILabel!
    @IBOutlet weak var friendCompanyStatus: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        friendCompanyImage.layer.masksToBounds = true
        friendCompanyImage.layer.cornerRadius = 5
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
