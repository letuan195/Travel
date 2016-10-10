//
//  MapViewController.swift
//  Travel
//
//  Created by Elight on 8/11/16.
//  Copyright © 2016 Elight. All rights reserved.
//

import UIKit
import StoreKit

class MapViewController: UIViewController {
    
    var isPurchased: Bool = false
    var products: [SKProduct] = []
    var fileNameDownload: String?
    var code: String?
    var mapToUnlock: String?
    
    let transition = BubbleTransition()
    var locationTouch: CGPoint = CGPoint(x: 0.0, y: 0.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if Main.travelUltis.isConnectedToNetwork() {
            reload()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

}
extension MapViewController: UIViewControllerTransitioningDelegate {
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let controller = segue.destinationViewController
        controller.transitioningDelegate = self
        controller.modalPresentationStyle = .Custom
    }
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .Present
        transition.startingPoint = locationTouch
        transition.bubbleColor = Main.travelUltis.hexStringToUIColor("#f44336")
        return transition
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .Dismiss
        transition.startingPoint = locationTouch
        transition.bubbleColor = Main.travelUltis.hexStringToUIColor("#f44336")
        return transition
    }
}

extension MapViewController {
    
    func reload(){
        products = []
        
        Main.store.requestProducts{success, products in
            if success {
                self.products = products!
            } else {
                Main.travelUltis.showAlert(viewcontroller: self, title: "Error", message: "Can't Purchase")
            }
            
            //self.refreshControl?.endRefreshing()
        }
    }
    func showPurchase() {
        if Main.travelUltis.isConnectedToNetwork() == false {
            Main.travelUltis.showAlert(viewcontroller: self, title: "", message: "Please connect internet!")
        } else {
            if (Main.store.canMakePayments() && self.products.count != 0){
                if let mapToUnlock = self.mapToUnlock {
                    for product in self.products {
                        if product.productIdentifier == mapToUnlock {
                            Main.store.buyProduct(product)
                        }
                    }
                }
                
            } else {
                Main.travelUltis.showAlert(viewcontroller: self, title: "Error", message: "Not Valueable!")
            }
        }
    }
    /*func askPurchase(){
        let alertVC = UIAlertController(title: "Buy Product", message: "Please buy the app with $1.99 to continue", preferredStyle: .Alert)
        let noAction = UIAlertAction(title: "Cancel", style: .Cancel) { (alert) in
        }
        let yesAction = UIAlertAction(title: "Continue", style: .Default) { (alert) in
            self.showOptionParchase()
        }
        alertVC.addAction(noAction)
        alertVC.addAction(yesAction)
        self.presentViewController(alertVC, animated: true) {
            //print("demo")
        }
    }*/
    func showOptionParchase(){
        let alertVC = UIAlertController(title: "Please choose one of the options below to continue", message: "", preferredStyle: .ActionSheet)
        let codeAction = UIAlertAction(title: "Enter code", style: .Default) { (alert) in
            //do something
            self.insertCode()
            
        }
        let buyAction = UIAlertAction(title: "Buy in Apple Store", style: .Default) { (alert) in
            //
            self.showPurchase()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (alert) in
            //
        }
        
        alertVC.addAction(buyAction)
        alertVC.addAction(codeAction)
        alertVC.addAction(cancelAction)
        self.presentViewController(alertVC, animated: true) {
            //print("demo")
        }
        
    }
    func insertCode(){
        let alertController = UIAlertController(title: "Input code", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        
        let saveAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {
            alert -> Void in
            
            let firstTextField = alertController.textFields![0] as UITextField
            if let code = self.code, mapToUnlock = self.mapToUnlock, fileNameDownload = self.fileNameDownload {
                if (firstTextField.text == code) {
                    self.isPurchased = true
                    Main.store.insertPurchased(mapToUnlock)
                    NSUserDefaults.standardUserDefaults().setBool(true, forKey: mapToUnlock)
                    NSUserDefaults.standardUserDefaults().synchronize()
                    
                    Main.travelUltis.download(viewcontroller: self, filename: fileNameDownload)
                } else {
                    Main.travelUltis.showAlert(viewcontroller: self, title: "Error", message: "Code invalue")
                }
            }
            
            
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: {
            (action : UIAlertAction!) -> Void in
            
        })
        
        alertController.addTextFieldWithConfigurationHandler { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter code"
            textField.keyboardType = UIKeyboardType.Alphabet
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
}
extension MapViewController: RateDelegate {
    func onRate(rate: Bool) {
        if !rate {
            //askPurchase()
        } else {
            UIApplication.sharedApplication().openURL(NSURL(string : "itms-apps://itunes.apple.com/app/id1107627194")!)
        }
    }
}
extension MapViewController: ShowRateDelegate {
    func onShow() {
        if !isPurchased {
            let popup = PopupController
                .create(self)
                .customize([
                    PopupCustomOption.Scrollable(false),
                    PopupCustomOption.DismissWhenTaps(false)
                    ])
            
            let container = RateViewController.instance()
            container.closeHandler = { _ in
                popup.dismiss()
            }
            popup.show(container)
        }
    }
}
