//
//  SelectNewChatWorkTableViewCell.swift
//  RickM+
//
//  Created by RickSun on 2020/2/19.
//  Copyright © 2020 RickSun. All rights reserved.
//

import UIKit

class SelectNewChatWorkTableViewCell: UITableViewCell {
    @IBOutlet weak var selectChatWorkImage: UIImageView!
    
    @IBOutlet weak var selectChatWorkIcon: UIImageView!
    
    @IBOutlet weak var selectChatWorkName: UILabel!
    
    @IBOutlet weak var selectChatWorkStatus: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
