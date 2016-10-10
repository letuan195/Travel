//
//  RateViewController.swift
//  Travel
//
//  Created by Elight on 9/12/16.
//  Copyright © 2016 Elight. All rights reserved.
//

import UIKit

class RateViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var contentImageView: UIView!
    
    @IBOutlet weak var btRate: UIButton!
    @IBOutlet weak var btNot: UIButton!
    
    var closeHandler: (() -> Void)?
    
    var rateDelegate: RateDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.rateDelegate = Main.travelUltis.getVC() as! RateDelegate
        initView()
    }
    
    func initView() {
        contentView.layer.cornerRadius = 5
        contentImageView.layer.cornerRadius = 40
        btRate.layer.cornerRadius = 5
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clickRate(sender: AnyObject) {
        rateDelegate.onRate(true)
    }

    @IBAction func clickNotRate(sender: AnyObject) {
        rateDelegate.onRate(false)
        self.closeHandler?()
    }
    

}
extension RateViewController: PopupContentViewController {
    class func instance() -> RateViewController {
        let storyboard = UIStoryboard(name: "Rate", bundle: nil)
        return storyboard.instantiateViewControllerWithIdentifier("rateViewController") as! RateViewController
    }
    
    func sizeForPopup(popupController: PopupController, size: CGSize, showingKeyboard: Bool) -> CGSize {
        return CGSizeMake(280,320)
    }
}
