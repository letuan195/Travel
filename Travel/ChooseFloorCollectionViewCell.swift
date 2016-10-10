//
//  ChooseFloorCollectionViewCell.swift
//  Travel
//
//  Created by Elight on 8/30/16.
//  Copyright © 2016 Elight. All rights reserved.
//

import UIKit

class ChooseFloorCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    static let identifier = "chooseFloorCollectionViewCell"
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.layer.cornerRadius = max(self.frame.size.width, self.frame.size.height) / 2
        self.layer.borderWidth = 5
        self.layer.borderColor = Main.travelUltis.hexStringToUIColor("#ffffff").CGColor
    }
}
