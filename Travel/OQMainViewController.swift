//
//  OQMainViewController.swift
//  Travel
//
//  Created by Elight on 5/12/16.
//  Copyright © 2016 Elight. All rights reserved.
//

import UIKit
import StoreKit
import Alamofire

class OQMainViewController: MapViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var contentView: UIView!
    
    var bt1, bt2, bt3, bt4, bt5, bt6, bt7, bt8, bt9: UIButton!
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func initModel() {
        Main.travelUltis.setVC(vc: self)
        code = "pc2036285"
        fileNameDownload = "pc1.zip"
        mapToUnlock = Main.UnlockOldQuarter
        isPurchased = Main.store.isPurchasedProduct(Main.UnlockOldQuarter)
        
        if isPurchased {
            colorPurchase = "#3498db"
        } else {
            colorPurchase = "#DDDDDD"
        }
    }
    func initView() {
        let height = UIScreen.mainScreen().bounds.height - 44
        let widght = UIScreen.mainScreen().bounds.width
        var w = 45 * widght / 64 - 20
        var h = 415 * height / 968 - 20
        var frame = CGRectMake(w , h, 44, 44)
        bt1 = UIButton(frame: frame)
        bt1.setTitle("1", forState: .Normal)
        bt1.layer.cornerRadius = 22
        bt1.backgroundColor = Main.travelUltis.hexStringToUIColor("#3498db")
        bt1.tag = 1
        bt1.addTarget(self, action: #selector(OQMainViewController.btClick), forControlEvents: .TouchUpInside)
        self.contentView.addSubview(bt1)
        
        w = 52 * widght / 64 - 20
        h = 610 * height / 968 - 20
        frame = CGRectMake(w , h, 40, 40)
        bt2 = UIButton(frame: frame)
        bt2.setTitle("2", forState: .Normal)
        bt2.layer.cornerRadius = 22
        bt2.backgroundColor = Main.travelUltis.hexStringToUIColor(colorPurchase)
        bt2.tag = 2
        bt2.addTarget(self, action: #selector(OQMainViewController.btClick), forControlEvents: .TouchUpInside)
        self.contentView.addSubview(bt2)
        
        w = 58 * widght / 64 - 20
        h = 780 * height / 968 - 20
        frame = CGRectMake(w , h, 40, 40)
        bt5 = UIButton(frame: frame)
        bt5.setTitle("5", forState: .Normal)
        bt5.layer.cornerRadius = 22
        bt5.backgroundColor = Main.travelUltis.hexStringToUIColor(colorPurchase)
        bt5.tag = 5
        bt5.addTarget(self, action: #selector(OQMainViewController.btClick), forControlEvents: .TouchUpInside)
        self.contentView.addSubview(bt5)
        
        w = 325 * widght / 640 - 20
        h = 645 * height / 968 - 20
        frame = CGRectMake(w , h, 40, 40)
        bt3 = UIButton(frame: frame)
        bt3.setTitle("3", forState: .Normal)
        bt3.layer.cornerRadius = 22
        bt3.backgroundColor = Main.travelUltis.hexStringToUIColor(colorPurchase)
        bt3.tag = 3
        bt3.addTarget(self, action: #selector(OQMainViewController.btClick), forControlEvents: .TouchUpInside)
        self.contentView.addSubview(bt3)
    
        w = 36 * widght / 64 - 20
        h = 840 * height / 968 - 20
        frame = CGRectMake(w , h, 40, 40)
        bt4 = UIButton(frame: frame)
        bt4.setTitle("4", forState: .Normal)
        bt4.layer.cornerRadius = 22
        bt4.backgroundColor = Main.travelUltis.hexStringToUIColor(colorPurchase)
        bt4.tag = 4
        bt4.addTarget(self, action: #selector(OQMainViewController.btClick), forControlEvents: .TouchUpInside)
        self.contentView.addSubview(bt4)
        
        w = 8 * widght / 64 - 20
        h = 672 * height / 968 - 20
        frame = CGRectMake(w , h, 40, 40)
        bt6 = UIButton(frame: frame)
        bt6.setTitle("6", forState: .Normal)
        bt6.layer.cornerRadius = 22
        bt6.backgroundColor = Main.travelUltis.hexStringToUIColor(colorPurchase)
        bt6.tag = 6
        bt6.addTarget(self, action: #selector(OQMainViewController.btClick), forControlEvents: .TouchUpInside)
        self.contentView.addSubview(bt6)
        
        w = 26 * widght / 64 - 20
        h = 311 * height / 968 - 20
        frame = CGRectMake(w , h, 40, 40)
        bt7 = UIButton(frame: frame)
        bt7.setTitle("7", forState: .Normal)
        bt7.layer.cornerRadius = 22
        bt7.backgroundColor = Main.travelUltis.hexStringToUIColor(colorPurchase)
        bt7.tag = 7
        bt7.addTarget(self, action: #selector(OQMainViewController.btClick), forControlEvents: .TouchUpInside)
        self.contentView.addSubview(bt7)
        
        w = 29 * widght / 64 - 20
        h = 131 * height / 968 - 20
        frame = CGRectMake(w , h, 40, 40)
        bt8 = UIButton(frame: frame)
        bt8.setTitle("8", forState: .Normal)
        bt8.layer.cornerRadius = 22
        bt8.backgroundColor = Main.travelUltis.hexStringToUIColor(colorPurchase)
        bt8.tag = 8
        bt8.addTarget(self, action: #selector(OQMainViewController.btClick), forControlEvents: .TouchUpInside)
        self.contentView.addSubview(bt8)
        
        w = 38 * widght / 64 - 20
        h = 60 * height / 968 - 20
        frame = CGRectMake(w , h, 40, 40)
        bt9 = UIButton(frame: frame)
        bt9.setTitle("9", forState: .Normal)
        bt9.layer.cornerRadius = 22
        bt9.backgroundColor = Main.travelUltis.hexStringToUIColor(colorPurchase)
        bt9.tag = 9
        bt9.addTarget(self, action: #selector(OQMainViewController.btClick), forControlEvents: .TouchUpInside)
        self.contentView.addSubview(bt9)
        
        
    }
    func btClick(sender: UIButton) {
        btTag = sender.tag
        locationTouch.x = sender.center.x
        locationTouch.y = sender.center.y + 44
        
        var nextViewController :UIViewController!
        
        if btTag == 1 {
            let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
            let url = NSURL(fileURLWithPath: path)
            let filePath = url.URLByAppendingPathComponent("pc0.zip").path!
            let fileManager = NSFileManager.defaultManager()
            if fileManager.fileExistsAtPath(filePath) {
                nextViewController = Main.storyBoard.instantiateViewControllerWithIdentifier("oQNSMainViewController") as! OQNSMainViewController
                nextViewController.transitioningDelegate = self
                nextViewController.modalPresentationStyle = .Custom
                self.presentViewController(nextViewController, animated:true, completion:nil)
            } else {
                Main.travelUltis.download(viewcontroller: self, filename: "pc0.zip")
            }
            
        }  else {
            if isPurchased {
                let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
                let url = NSURL(fileURLWithPath: path)
                let filePath = url.URLByAppendingPathComponent("pc1.zip").path!
                let fileManager = NSFileManager.defaultManager()
                if fileManager.fileExistsAtPath(filePath) {
                    purchased(btTag)
                } else {
                    Main.travelUltis.download(viewcontroller: self, filename: "pc1.zip")
                }
                
            } else {
                //showOptionParchase()
                showPurchase()
            }
        }
    }
    func purchased(tag: Int) {
        var nextViewController: UIViewController!
        var jsonMap: JsonMap!
        if btTag == 2{
            jsonMap = Main.travelUltis.getDataTable("pc2")
        } else if btTag == 3{
            jsonMap = Main.travelUltis.getDataTable("pc4")
        } else if btTag == 4{
            jsonMap = Main.travelUltis.getDataTable("pc5")
        } else if btTag == 5{
            jsonMap = Main.travelUltis.getDataTable("pc3")
        } else if btTag == 6{
            jsonMap = Main.travelUltis.getDataTable("pc6")
        } else if btTag == 7{
            jsonMap = Main.travelUltis.getDataTable("pc7")
        } else if btTag == 8{
            jsonMap = Main.travelUltis.getDataTable("pc8")
        } else if btTag == 9{
            jsonMap = Main.travelUltis.getDataTable("pc9")
        } else {
            jsonMap = Main.travelUltis.getDataTable("pc2")
        }
        Main.travelUltis.setJsonMap(json: jsonMap)
        Main.travelUltis.setIndexMap(index: 0)
        nextViewController = Main.storyBoard.instantiateViewControllerWithIdentifier("childMapViewController") as! ChildMapViewController
        let navController = UINavigationController(rootViewController: nextViewController)
        
        navController.transitioningDelegate = self
        navController.modalPresentationStyle = .Custom
        self.presentViewController(navController, animated:true, completion:nil)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        Main.GAI.addScreenTracking(title: "Main Map The Old Quarter")
        
    }
    
    @IBAction func navHome(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func navInfo(sender: AnyObject) {
        locationTouch.x = UIScreen.mainScreen().bounds.width - 25
        locationTouch.y = 22
        
        let nextViewController = Main.storyBoard.instantiateViewControllerWithIdentifier("childMapViewController") as! ChildMapViewController
        
        let navController = UINavigationController(rootViewController: nextViewController)
        navController.transitioningDelegate = self
        navController.modalPresentationStyle = .Custom
        
        let jsonMap = Main.travelUltis.getDataTable("pc0")
        Main.travelUltis.setIndexMap(index: 0)
        Main.travelUltis.setJsonMap(json: jsonMap)
        
        self.presentViewController(nextViewController, animated:true, completion:nil)
    }
}
extension OQMainViewController: UIScrollViewDelegate {
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.contentView
    }
}

