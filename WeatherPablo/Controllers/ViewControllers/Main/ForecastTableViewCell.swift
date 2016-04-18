//
//  ForecastTableViewCell.swift
//  WeatherPablo
//
//  Created by Pablo Roca Rozas on 17/4/16.
//  Copyright © 2016 PR2Studio. All rights reserved.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {

   @IBOutlet weak var lblDateAndTime: UILabel!
   @IBOutlet weak var lblwdescription: UILabel!
   @IBOutlet weak var viewImage: UIImageView!
   @IBOutlet weak var lbltemp_max: UILabel!
   @IBOutlet weak var lbltemp_min: UILabel!
   @IBOutlet weak var lblwindspeed: UILabel!
   @IBOutlet weak var lblclouds: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
