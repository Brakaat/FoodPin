//
//  RestaurantTableViewCell.swift
//  FoodPin
//
//  Created by Kiri on 2020/4/28.
//  Copyright © 2020 bararaka. All rights reserved.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var thumbnailImageView: UIImageView!{
            didSet {
                // Need to remove this part of code
    //            thumbnailImageView.layer.cornerRadius = thumbnailImageView.bounds.width / 2
    //            thumbnailImageView.clipsToBounds = true
            }
        }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
