//
//  PropertyTableViewCell.swift
//  SentiaCodeTest
//
//  Created by Simeng Liu on 14/5/18.
//  Copyright © 2018 Simeng Liu. All rights reserved.
//

import UIKit

class PropertyTableViewCell: UITableViewCell {
    
    @IBOutlet var avatarImageview: UIImageView!
    @IBOutlet var ownerNameLabel: UILabel!
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var suburbLabel: UILabel!
    
    @IBOutlet var bedroomNumLabel: UILabel!
    @IBOutlet var bathroomNumLabel: UILabel!
    @IBOutlet var carpartNumLabel: UILabel!
    
    @IBOutlet var isFeaturedLabel: UILabel!
    @IBOutlet var propertyImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.avatarImageview.layer.cornerRadius = self.avatarImageview.frame.width/2
        self.avatarImageview.layer.masksToBounds = true
        
        self.addressLabel.lineBreakMode = .byWordWrapping
        self.addressLabel.numberOfLines = 0
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
