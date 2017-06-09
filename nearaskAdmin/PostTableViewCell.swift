//
//  PostTableViewCell.swift
//  nearaskAdmin
//
//  Created by Shi Ling on 7/6/17.
//  Copyright © 2017 Shi Ling. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var profileThumbNail: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeFromNowLabel: UILabel!
    
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryIconLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var categorynameLabel: UILabel!
    @IBOutlet weak var mediaView: UIView!
    @IBOutlet weak var mediaHeightAnchor: NSLayoutConstraint!
    @IBOutlet weak var desciptionBottomMarginConstrain: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
