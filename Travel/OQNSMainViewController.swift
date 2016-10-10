//
//  OQNSMainViewController.swift
//  Travel
//
//  Created by Elight on 6/7/16.
//  Copyright © 2016 Elight. All rights reserved.
//

import UIKit

class OQNSMainViewController: UIViewController {
    
    var bt1, bt2, bt3, bt4, btInfo: UIButton!
    
    let transition = BubbleTransition()
    var locationTouch: CGPoint = CGPoint(x: 0.0, y: 0.0)
    
    var btTag: Int = 0
    var jsonMap: JsonMap!
    var colorTransacsion: String = "#f44336"
    

    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
        
        jsonMap = Main.travelUltis.getDataTable("pc1")
        Main.travelUltis.setJsonMap(json: jsonMap)
    }

    func initView() {
        let height = UIScreen.mainScreen().bounds.height - 44
        let widght = UIScreen.mainScreen().bounds.width
        var w = 325 * widght / 640 - 25
        var h = 800 * height / 968 + 19
        var frame = CGRectMake(w , h, 50, 50)
        bt1 = UIButton(frame: frame)
        bt1.setTitle("1", forState: .Normal)
        bt1.layer.cornerRadius = 22
        bt1.backgroundColor = Main.travelUltis.hexStringToUIColor("#3498db")
        bt1.tag = 1
        bt1.addTarget(self, action: #selector(OQNSMainViewController.btClick), forControlEvents: .TouchUpInside)
        self.view.addSubview(bt1)
        
        w = 325 * widght / 640 - 25
        h = 610 * height / 968 + 19
        frame = CGRectMake(w , h, 50, 50)
        bt2 = UIButton(frame: frame)
        bt2.setTitle("2", forState: .Normal)
        bt2.layer.cornerRadius = 22
        bt2.backgroundColor = Main.travelUltis.hexStringToUIColor("#3498db")
        bt2.tag = 2
        bt2.addTarget(self, action: #selector(OQNSMainViewController.btClick), forControlEvents: .TouchUpInside)
        self.view.addSubview(bt2)
        
        w = 325 * widght / 640 - 25
        h = 455 * height / 968 + 19
        frame = CGRectMake(w , h, 50, 50)
        bt3 = UIButton(frame: frame)
        bt3.setTitle("3", forState: .Normal)
        bt3.layer.cornerRadius = 22
        bt3.backgroundColor = Main.travelUltis.hexStringToUIColor("#3498db")
        bt3.tag = 3
        bt3.addTarget(self, action: #selector(OQNSMainViewController.btClick), forControlEvents: .TouchUpInside)
        self.view.addSubview(bt3)
        
        w = 325 * widght / 640 - 25
        h = 230 * height / 968 + 19
        frame = CGRectMake(w , h, 50, 50)
        bt4 = UIButton(frame: frame)
        bt4.setTitle("1", forState: .Normal)
        bt4.layer.cornerRadius = 22
        bt4.backgroundColor = Main.travelUltis.hexStringToUIColor("#3498db")
        bt4.tag = 4
        bt4.addTarget(self, action: #selector(OQNSMainViewController.btClick), forControlEvents: .TouchUpInside)
        self.view.addSubview(bt4)
        
        w = 325 * widght / 640 - 25
        h = 900 * height / 968 + 19
        frame = CGRectMake(w , h, 50, 50)
        btInfo = UIButton(frame: frame)
        btInfo.setTitle("i", forState: .Normal)
        btInfo.layer.cornerRadius = 22
        btInfo.backgroundColor = Main.travelUltis.hexStringToUIColor("#3498db")
        btInfo.tag = 0
        btInfo.addTarget(self, action: #selector(OQNSMainViewController.btClick), forControlEvents: .TouchUpInside)
        self.view.addSubview(btInfo)
        
        
    }
    func btClick(sender: UIButton) {
        btTag = sender.tag
        locationTouch.x = sender.center.x
        locationTouch.y = sender.center.y
        colorTransacsion = "#33c4f4"
        
        switch btTag {
        case 0:
            Main.travelUltis.setIndexMap(index: 0)
            break
        case 1:
            Main.travelUltis.setIndexMap(index: 1)
            break
        case 2:
            Main.travelUltis.setIndexMap(index: 2)
            break
        case 3:
            Main.travelUltis.setIndexMap(index: 3)
            break
        case 4:
            Main.travelUltis.setIndexMap(index: 4)
            break
        default:
            Main.travelUltis.setIndexMap(index: 1)
            break
        }
        let nextViewController = Main.storyBoard.instantiateViewControllerWithIdentifier("childMapViewController") as! ChildMapViewController
        let navController = UINavigationController(rootViewController: nextViewController)
        navController.transitioningDelegate = self
        navController.modalPresentationStyle = .Custom
        self.presentViewController(navController, animated:true, completion:nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    override func viewWillAppear(animated: Bool) {
        Main.GAI.addScreenTracking(title: "Map Ngoc Son Temple")
    }
    @IBAction func navBack(sender: AnyObject) {
        let showRate = Main.travelUltis.getVC() as! ShowRateDelegate
        showRate.onShow()
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
extension OQNSMainViewController: UIViewControllerTransitioningDelegate {
    /*
     override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
     if let touch = touches.first {
     locationTouch = touch.locationInView(view)
     }
     }
     */
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