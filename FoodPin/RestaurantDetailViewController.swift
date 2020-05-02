//
//  RestaurantDetailViewController.swift
//  FoodPin
//
//  Created by Kiri on 2020/5/2.
//  Copyright © 2020 bararaka. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: UIViewController {

    @IBOutlet var restaurantImageView: UIImageView!
    @IBOutlet var restaurantNameLabel: UILabel!
    @IBOutlet var restaurantTypeLabel: UILabel!
    @IBOutlet var restaurantLocationLabel: UILabel!
    
    var restaurantImageName = ""
    var restaurantName = ""
    var restaurantType = ""
    var restaurantLocation = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        restaurantNameLabel.text = restaurantName
        restaurantTypeLabel.text = restaurantType
        restaurantLocationLabel.text = restaurantLocation
        restaurantImageView.image = UIImage(named: restaurantImageName)
        // Do any additional setup after loading the view.
    }

}
