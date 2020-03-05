//
//  GiftProductListTableViewCell.swift
//  RickM+
//
//  Created by RickSun on 2020/2/3.
//  Copyright © 2020 RickSun. All rights reserved.
//

import UIKit

class GiftProductListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var giftProductListImage: UIImageView!
    @IBOutlet weak var giftProductListName: UILabel!
    @IBOutlet weak var giftProductListComment: UILabel!
    @IBOutlet weak var giftProductListFeature: UILabel!
    @IBOutlet weak var giftProductPrice: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
