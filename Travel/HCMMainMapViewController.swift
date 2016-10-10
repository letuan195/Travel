//
//  HCMMainMapViewController.swift
//  Travel
//
//  Created by Elight on 7/28/16.
//  Copyright © 2016 Elight. All rights reserved.
//
import StoreKit
import UIKit

class HCMMainMapViewController: MapViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var contentView: UIView!
    
    var btInfo, bt1, bt2, bt3, bt4, bt5, bt6, bt7: UIButton!
    
    var btTag: Int = 0
    var colorPurchase = "#DDDDDD"


    override func viewDidLoad() {
        super.viewDidLoad()
        
        initModel()
        initView()
        
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 6.0
    }

    func initModel() {
        Main.travelUltis.setVC(vc: self)
        code = "lb2036285"
        fileNameDownload = "lb1.zip"
        mapToUnlock = Main.UnlockHCM
        isPurchased = Main.store.isPurchasedProduct(Main.UnlockHCM)
        
        if isPurchased {
            colorPurchase = "#3498db"
        } else {
            colorPurchase = "#DDDDDD"
        }
    }
    
    func initView() {
        let height = UIScreen.mainScreen().bounds.height - 44
        let widght = UIScreen.mainScreen().bounds.width
        
        var w = 1528 * widght / 2480 - 20
        var h = 2300 * height / 3508 - 20
        var frame = CGRectMake(w , h, 40, 40)
        btInfo = UIButton(frame: frame)
        btInfo.setTitle("i", forState: .Normal)
        btInfo.layer.cornerRadius = 20
        btInfo.backgroundColor = Main.travelUltis.hexStringToUIColor("#3498db")
        btInfo.tag = 1
        btInfo.addTarget(self, action: #selector(HCMMainMapViewController.btClick), forControlEvents: .TouchUpInside)
        self.contentView.addSubview(btInfo)
        
        w = 1221 * widght / 2480 - 20
        h = 2843 * height / 3508 - 20
        frame = CGRectMake(w , h, 40, 40)
        bt1 = UIButton(frame: frame)
        bt1.setTitle("1", forState: .Normal)
        bt1.layer.cornerRadius = 20
        bt1.backgroundColor = Main.travelUltis.hexStringToUIColor("#3498db")
        bt1.tag = 1
        bt1.addTarget(self, action: #selector(HCMMainMapViewController.btClick), forControlEvents: .TouchUpInside)
        self.contentView.addSubview(bt1)
        
        w = 1221 * widght / 2480 - 20
        h = 2843 * height / 3508 - 20
        w = 907 * widght / 2480 - 20
        h = 1722 * height / 3508 - 20
        frame = CGRectMake(w , h, 40, 40)
        bt2 = UIButton(frame: frame)
        bt2.setTitle("2", forState: .Normal)
        bt2.layer.cornerRadius = 20
        bt2.backgroundColor = Main.travelUltis.hexStringToUIColor("#3498db")
        bt2.tag = 2
        bt2.addTarget(self, action: #selector(HCMMainMapViewController.btClick), forControlEvents: .TouchUpInside)
        self.contentView.addSubview(bt2)
        
        w = 2064 * widght / 2480 - 20
        h = 1658 * height / 3508 - 20
        frame = CGRectMake(w , h, 40, 40)
        bt3 = UIButton(frame: frame)
        bt3.setTitle("3", forState: .Normal)
        bt3.layer.cornerRadius = 20
        bt3.backgroundColor = Main.travelUltis.hexStringToUIColor(colorPurchase)
        bt3.tag = 3
        bt3.addTarget(self, action: #selector(HCMMainMapViewController.btClick), forControlEvents: .TouchUpInside)
        self.contentView.addSubview(bt3)
        
        w = 2000 * widght / 2480 - 20
        h = 972 * height / 3508 - 20
        frame = CGRectMake(w , h, 40, 40)
        bt4 = UIButton(frame: frame)
        bt4.setTitle("4", forState: .Normal)
        bt4.layer.cornerRadius = 20
        bt4.backgroundColor = Main.travelUltis.hexStringToUIColor(colorPurchase)
        bt4.tag = 4
        bt4.addTarget(self, action: #selector(HCMMainMapViewController.btClick), forControlEvents: .TouchUpInside)
        self.contentView.addSubview(bt4)
        
        w = 2178 * widght / 2480 - 20
        h = 415 * height / 3508 - 20
        frame = CGRectMake(w , h, 40, 40)
        bt5 = UIButton(frame: frame)
        bt5.setTitle("5", forState: .Normal)
        bt5.layer.cornerRadius = 20
        bt5.backgroundColor = Main.travelUltis.hexStringToUIColor(colorPurchase)
        bt5.tag = 5
        bt5.addTarget(self, action: #selector(HCMMainMapViewController.btClick), forControlEvents: .TouchUpInside)
        self.contentView.addSubview(bt5)
        
        w = 1057 * widght / 2480 - 20
        h = 908 * height / 3508 - 20
        frame = CGRectMake(w , h, 40, 40)
        bt6 = UIButton(frame: frame)
        bt6.setTitle("6", forState: .Normal)
        bt6.layer.cornerRadius = 20
        bt6.backgroundColor = Main.travelUltis.hexStringToUIColor(colorPurchase)
        bt6.tag = 6
        bt6.addTarget(self, action: #selector(HCMMainMapViewController.btClick), forControlEvents: .TouchUpInside)
        self.contentView.addSubview(bt6)
        
        w = 414 * widght / 2480 - 20
        h = 293 * height / 3508 - 20
        frame = CGRectMake(w , h, 40, 40)
        bt7 = UIButton(frame: frame)
        bt7.setTitle("7", forState: .Normal)
        bt7.layer.cornerRadius = 20
        bt7.backgroundColor = Main.travelUltis.hexStringToUIColor(colorPurchase)
        bt7.tag = 7
        bt7.addTarget(self, action: #selector(HCMMainMapViewController.btClick), forControlEvents: .TouchUpInside)
        self.contentView.addSubview(bt7)
        
    }
    func btClick(sender:UIButton){
        btTag = sender.tag
        locationTouch.x = sender.center.x
        locationTouch.y = sender.center.y + 44
        
        var nextViewController :UIViewController!
        if btTag > 2 {
            if isPurchased {
                let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
                let url = NSURL(fileURLWithPath: path)
                let filePath = url.URLByAppendingPathComponent("lb1.zip").path!
                let fileManager = NSFileManager.defaultManager()
                if fileManager.fileExistsAtPath(filePath) {
                    purchased(btTag)
                } else {
                    Main.travelUltis.download(viewcontroller: self, filename: "lb1.zip")
                }
                
            } else {
                //showOptionParchase()
                showPurchase()
            }
        } else {
            let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
            let url = NSURL(fileURLWithPath: path)
            let filePath = url.URLByAppendingPathComponent("lb0.zip").path!
            let fileManager = NSFileManager.defaultManager()
            if fileManager.fileExistsAtPath(filePath) {
                var jsonMap: JsonMap!
                if btTag == 0 {
                    jsonMap = Main.travelUltis.getDataTable("lb0")
                } else if btTag == 1 {
                    jsonMap = Main.travelUltis.getDataTable("lb1")
                } else if (btTag == 2) {
                    jsonMap = Main.travelUltis.getDataTable("lb2")
                }
                nextViewController = Main.storyBoard.instantiateViewControllerWithIdentifier("childMapViewController") as! ChildMapViewController
                let navController = UINavigationController(rootViewController: nextViewController)
                navController.transitioningDelegate = self
                navController.modalPresentationStyle = .Custom
                Main.travelUltis.setIndexMap(index: 0)
                Main.travelUltis.setJsonMap(json: jsonMap)
                self.presentViewController(navController, animated:true, completion:nil)

            } else {
                Main.travelUltis.download(viewcontroller: self, filename: "lb0.zip")
            }
        }
    }
    func purchased(tag: Int) {
        var nextViewController: UIViewController!
        var jsonMap: JsonMap!
        if btTag == 7 {
            jsonMap = Main.travelUltis.getDataTable("lb7")
            Main.travelUltis.setJsonMap(json: jsonMap)
            nextViewController = Main.storyBoard.instantiateViewControllerWithIdentifier("hCMFloorMapViewController") as! HCMFloorMapViewController
            nextViewController.transitioningDelegate = self
            nextViewController.modalPresentationStyle = .Custom
            self.presentViewController(nextViewController, animated:true, completion:nil)
        } else {
            if btTag == 3 {
                jsonMap = Main.travelUltis.getDataTable("lb3")
            } else if btTag == 4 {
                jsonMap = Main.travelUltis.getDataTable("lb4")
            } else if btTag == 5 {
                jsonMap = Main.travelUltis.getDataTable("lb5")
            } else if btTag == 6 {
                jsonMap = Main.travelUltis.getDataTable("lb6")
            }
            Main.travelUltis.setJsonMap(json: jsonMap)
            Main.travelUltis.setIndexMap(index: 0)
            nextViewController = Main.storyBoard.instantiateViewControllerWithIdentifier("childMapViewController") as! ChildMapViewController
            
            let navController = UINavigationController(rootViewController: nextViewController)
            navController.transitioningDelegate = self
            navController.modalPresentationStyle = .Custom
            
            self.presentViewController(navController, animated:true, completion:nil)
        }
        
    }

    override func viewWillAppear(animated: Bool) {
        Main.GAI.addScreenTracking(title: "Main Map Ho Chi Minh Mausoleum")
    }
    
    @IBAction func navHome(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    

}

extension HCMMainMapViewController: UIScrollViewDelegate {
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.contentView
    }
}
