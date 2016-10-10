//
//  HCMFloorViewController.swift
//  Travel
//
//  Created by Elight on 8/4/16.
//  Copyright © 2016 Elight. All rights reserved.
//

import UIKit

class HCMFloorViewController: UIViewController {

    let transition = BubbleTransition()
    var locationTouch: CGPoint = CGPoint(x: 0.0, y: 0.0)
    var colorTransacsion: String = "#f44336"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func navHomeClick(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func navInfoClick(sender: AnyObject) {
        Main.travelUltis.setIndexMap(index: 0)
        locationTouch.x = UIScreen.mainScreen().bounds.width - 25
        locationTouch.y = 22
        
        nextChildViewController()
    }

    @IBAction func btFloor1Click(sender: AnyObject) {
        Main.travelUltis.setIndexMap(index: 1)
        locationTouch.x = sender.center.x
        locationTouch.y = sender.center.y + 44
        
        nextChildViewController()
        
    }
    @IBAction func btFloor2Click(sender: AnyObject) {
        Main.travelUltis.setIndexMap(index: 2)
        locationTouch.x = sender.center.x
        locationTouch.y = sender.center.y + 44
        
        nextChildViewController()
    }
    @IBAction func btFloor4Click(sender: AnyObject) {
        Main.travelUltis.setIndexMap(index: 3)
        locationTouch.x = sender.center.x
        locationTouch.y = sender.center.y + 44
        
        nextChildViewController()
    }
    
    func nextChildViewController() {
        let nextViewController = Main.storyBoard.instantiateViewControllerWithIdentifier("childMapViewController") as! ChildMapViewController
        nextViewController.transitioningDelegate = self
        nextViewController.modalPresentationStyle = .Custom
        
        self.presentViewController(nextViewController, animated:true, completion:nil)
    }
}
extension HCMFloorViewController: UIViewControllerTransitioningDelegate {
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let controller = segue.destinationViewController
        controller.transitioningDelegate = self
        controller.modalPresentationStyle = .Custom
    }
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .Present
        transition.startingPoint = locationTouch
        transition.bubbleColor = Main.travelUltis.hexStringToUIColor(colorTransacsion)
        return transition
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .Dismiss
        transition.startingPoint = locationTouch
        transition.bubbleColor = Main.travelUltis.hexStringToUIColor(colorTransacsion)
        return transition
    }
}
