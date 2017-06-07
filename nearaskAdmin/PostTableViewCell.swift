//
//  PostTableViewCell.swift
//  nearaskAdmin
//
//  Created by Shi Ling on 7/6/17.
//  Copyright © 2017 Shi Ling. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeFromNowLabel: UILabel!
    @IBOutlet weak var descrLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
