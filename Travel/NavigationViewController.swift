//
//  NavigationViewController.swift
//  Travel
//
//  Created by Elight on 5/6/16.
//  Copyright © 2016 Elight. All rights reserved.
//

import MessageUI
import Foundation
import StoreKit

class NavigationViewController: UIViewController {

  
    @IBOutlet weak var tableView: UITableView!
    
    var listTittle:[String] = ["ENCOURAGE US", "Feedback", "Restore"]
    var lsttImage:[String] = ["rate","feedback", "restore"]
    
    var products: [SKProduct] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        tableView.tableFooterView = UIView(frame:CGRectZero)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        Main.GAI.addScreenTracking(title: "Screen Setting")
    }
    
    func showRate() {
        let rate: UIAlertController = UIAlertController(title: "Rate us", message: "Rate in the app store", preferredStyle: .Alert)
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
            //Do some other stuff
        }
        rate.addAction(cancelAction)
        
        let rateAction: UIAlertAction = UIAlertAction(title: "Ok", style: .Default) { action -> Void in
            //Do some other stuff
            UIApplication.sharedApplication().openURL(NSURL(string : "itms-apps://itunes.apple.com/app/id1107627194")!)
        }
        rate.addAction(rateAction)
        
        self.presentViewController(rate, animated: true, completion: nil)
        
    }
    func restorePurchase() {
        if Main.travelUltis.isConnectedToNetwork() == true {
            
            Main.store.requestProducts{success, products in
                if success {
                    self.products = products!
                } else {
                    Main.travelUltis.showAlert(viewcontroller: self, title: "Error", message: "Can't Purchase")
                }
                
                //self.refreshControl?.endRefreshing()
            }
            if Main.store.canMakePayments() {
                Main.store.restorePurchases()
            }
        } else {
            Main.travelUltis.showAlert(viewcontroller: self, title: "Error", message: "Please connect internet!")
        }
    }

}

extension NavigationViewController: UITableViewDelegate, UITableViewDataSource {
  
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listTittle.count
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.row {
        case 0:
            if Main.travelUltis.isConnectedToNetwork() {
                showRate()
            } else {
                Main.travelUltis.showAlert(viewcontroller: self, title: "", message: "Please connect to the internet ")
            }
            break
        case 1:
            let mailComposeViewController = configuredMailComposeViewController()
            if MFMailComposeViewController.canSendMail() {
                self.presentViewController(mailComposeViewController, animated: true, completion: nil)
            } else {
                Main.travelUltis.showAlert(viewcontroller: self, title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.")
            }
            break
        case 2:
            restorePurchase()
            break
        default:
            break
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let mycell = tableView.dequeueReusableCellWithIdentifier("MyCell", forIndexPath: indexPath) as! ItemNavigationTableViewCell
        mycell.label.text = listTittle[indexPath.row]
        mycell.iv.image = UIImage(named: lsttImage[indexPath.row])
        
        return mycell
    }
    
}
extension NavigationViewController: MFMailComposeViewControllerDelegate {
    //feedback
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients(["info.vietnamtravelmate@gmail.com"])
        mailComposerVC.setSubject("Review about Van Mieu Audio Guide")
        mailComposerVC.setMessageBody("Thanks you!", isHTML: false)
        
        return mailComposerVC
    }
    
    // MARK: MFMailComposeViewControllerDelegate
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
}
