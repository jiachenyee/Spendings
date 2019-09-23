//
//  SpendingsTableViewCell.swift
//  Fund Inc.
//
//  Created by JiaChen(: on 18/9/19.
//  Copyright © 2019 Swift Innovators' Summit. All rights reserved.
//

import UIKit

class SpendingsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var arrowImageView: UIImageView!
    @IBOutlet weak var costAndTimeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var curvedImageViewView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        curvedImageViewView.layer.cornerRadius = curvedImageViewView.frame.height / 2
        curvedImageViewView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
