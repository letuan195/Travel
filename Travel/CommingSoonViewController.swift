//
//  CommingSoonViewController.swift
//  Travel
//
//  Created by Elight on 6/3/16.
//  Copyright © 2016 Elight. All rights reserved.
//

import UIKit
import MessageUI
import SwiftMailgun

class CommingSoonViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var btDone: UIButton!
    @IBOutlet weak var btNoThanks: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btDone.layer.borderWidth = 1.0
        btDone.layer.cornerRadius = 4.0
        btDone.layer.borderColor = Main.travelUltis.hexStringToUIColor("#f44336").CGColor
        btNoThanks.layer.borderWidth = 1.0
        btNoThanks.layer.borderColor = Main.travelUltis.hexStringToUIColor("#f44336").CGColor
        btNoThanks.layer.cornerRadius = 4.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    @IBAction func clickOK(sender: AnyObject) {
        
        let mailgun = MailgunAPI(apiKey: "key-3e0cda33e8865e771e5baba52bfbcffe", clientDomain: "sandbox1301d6dada344584a945dd8943b88d5b.mailgun.org")
        
        let email = textField.text!
        
        mailgun.sendEmail(to: "info.vietnamtravelmate@gmail.com", from: "kid1412bk@gmail.com", subject: email, bodyHTML: "<b>test<b>") { mailgunResult in
            
            if Main.travelUltis.isConnectedToNetwork() {
                if (mailgunResult.success && Main.travelUltis.isValidEmail(email: email)){
                    print("Email was sent")
                    
                    let alert: UIAlertController = UIAlertController(title: "", message: "Thanks you so much!", preferredStyle: .Alert)
                    let okAction: UIAlertAction = UIAlertAction(title: "OK", style: .Cancel) { action -> Void in
                        self.dismissViewControllerAnimated(true, completion: nil)
                    }
                    alert.addAction(okAction)
                    self.presentViewController(alert, animated: true, completion: nil)
                } else {
                    Main.travelUltis.showAlert(viewcontroller: self, title: "", message: "Sorry, We're not received email!")
                }
            } else {
                Main.travelUltis.showAlert(viewcontroller: self, title: "", message: "Please connect to the internet!")
            }
            
            
        }

    }

    @IBAction func backClick(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
extension CommingSoonViewController: MFMailComposeViewControllerDelegate {
    //feedback
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients(["info.vietnamtravelmate@gmail.com"])
        mailComposerVC.setSubject("")
        mailComposerVC.setMessageBody("Comming Soon", isHTML: false)
        
        return mailComposerVC
    }
    
    // MARK: MFMailComposeViewControllerDelegate
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
}
