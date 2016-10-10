//
//  BuyProductViewController.swift
//  Travel
//
//  Created by Elight on 6/26/16.
//  Copyright © 2016 Elight. All rights reserved.
//

import UIKit

class BuyProductViewController: UIViewController {
    @IBOutlet weak var headerView: UIView!

    @IBOutlet weak var btnContinue: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.layer.borderWidth = 1.0
        self.view.layer.borderColor = Main.travelUltis.hexStringToUIColor("#f44336").CGColor
        self.view.layer.cornerRadius = 10.0
        
        headerView.layer.borderWidth = 1.0
        headerView.layer.borderColor = Main.travelUltis.hexStringToUIColor("#f44336").CGColor
        
        btnCancel.layer.borderWidth = 1.0
        btnCancel.layer.borderColor = Main.travelUltis.hexStringToUIColor("#f44336").CGColor
        btnCancel.layer.cornerRadius = 10.0
        
        btnContinue.layer.borderWidth = 1.0
        btnContinue.layer.borderColor = Main.travelUltis.hexStringToUIColor("#f44336").CGColor
        btnCancel.layer.cornerRadius = 10.0
        
        self.view.frame.size = CGSizeMake(280,220)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
extension BuyProductViewController: PopupContentViewController {
    class func instance() -> BuyProductViewController {
        let storyboard = UIStoryboard(name: "Popup", bundle: nil)
        return storyboard.instantiateViewControllerWithIdentifier("BuyProductViewController") as! BuyProductViewController
    }
    
    func sizeForPopup(popupController: PopupController, size: CGSize, showingKeyboard: Bool) -> CGSize {
        return CGSizeMake(280,220)
    }
}
