//
//  FoodTourItemTableViewCell.swift
//  Travel
//
//  Created by Elight on 8/4/16.
//  Copyright © 2016 Elight. All rights reserved.
//

import UIKit

class FoodTourItemTableViewCell: UITableViewCell {

    @IBOutlet weak var lb: UILabel!
    
    @IBOutlet weak var iv: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
