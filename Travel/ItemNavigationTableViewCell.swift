//
//  ItemNavigationTableViewCell.swift
//  Travel
//
//  Created by Elight on 5/6/16.
//  Copyright © 2016 Elight. All rights reserved.
//

import UIKit

class ItemNavigationTableViewCell: UITableViewCell {

  @IBOutlet weak var label: UILabel!
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
