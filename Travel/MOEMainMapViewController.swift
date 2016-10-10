//
//  MOEMainMapViewController.swift
//  Travel
//
//  Created by Elight on 7/29/16.
//  Copyright © 2016 Elight. All rights reserved.
//
import StoreKit
import UIKit

class MOEMainMapViewController: MapViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var contentView: UIView!
    
    var btInfo, bt1, bt2, bt3, bt4, bt5, bt6, bt7, bt8, bt9, bt10, bt11, bt12: UIButton!
    
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
        code = "bt2036285"
        fileNameDownload = "bt1.zip"
        mapToUnlock = Main.UnlockBTDTH
        isPurchased = Main.store.isPurchasedProduct(Main.UnlockBTDTH)
        
        if isPurchased {
            colorPurchase = "#3498db"
        } else {
            colorPurchase = "#DDDDDD"
        }
    }
    func initView() {
        let height = UIScreen.mainScreen().bounds.height - 44
        let widght = UIScreen.mainScreen().bounds.width
        
        var w = 196 * widght / 960 - 20
        var h = 1280 * height / 1440 - 20
        var frame = CGRectMake(w , h, 40, 40)
        btInfo = UIButton(frame: frame)
        btInfo.setTitle("i", forState: .Normal)
        btInfo.layer.cornerRadius = 22
        btInfo.backgroundColor = Main.travelUltis.hexStringToUIColor("#3498db")
        btInfo.tag = 0
        btInfo.addTarget(self, action: #selector(MOEMainMapViewController.btClick), forControlEvents: .TouchUpInside)
        self.contentView.addSubview(btInfo)
        
        w = 70 * widght / 960 - 20
        h = 1148 * height / 1440 - 20
        frame = CGRectMake(w , h, 40, 40)
        bt1 = UIButton(frame: frame)
        bt1.setTitle("1", forState: .Normal)
        bt1.layer.cornerRadius = 22
        bt1.backgroundColor = Main.travelUltis.hexStringToUIColor(colorPurchase)
        bt1.tag = 1
        bt1.addTarget(self, action: #selector(MOEMainMapViewController.btClick), forControlEvents: .TouchUpInside)
        self.contentView.addSubview(bt1)
        
        w = 435 * widght / 960 - 20
        h = 1271 * height / 1440 - 20
        frame = CGRectMake(w , h, 40, 40)
        bt2 = UIButton(frame: frame)
        bt2.setTitle("2", forState: .Normal)
        bt2.layer.cornerRadius = 22
        bt2.backgroundColor = Main.travelUltis.hexStringToUIColor(colorPurchase)
        bt2.tag = 2
        bt2.addTarget(self, action: #selector(MOEMainMapViewController.btClick), forControlEvents: .TouchUpInside)
        self.contentView.addSubview(bt2)
        
        w = 888 * widght / 960 - 20
        h = 989 * height / 1440 - 20
        frame = CGRectMake(w , h, 40, 40)
        bt3 = UIButton(frame: frame)
        bt3.setTitle("3", forState: .Normal)
        bt3.layer.cornerRadius = 22
        bt3.backgroundColor = Main.travelUltis.hexStringToUIColor("#3498db")
        bt3.tag = 3
        bt3.addTarget(self, action: #selector(MOEMainMapViewController.btClick), forControlEvents: .TouchUpInside)
        self.contentView.addSubview(bt3)
        
        w = 811 * widght / 960 - 20
        h = 798 * height / 1440 - 20
        frame = CGRectMake(w , h, 40, 40)
        bt4 = UIButton(frame: frame)
        bt4.setTitle("4", forState: .Normal)
        bt4.layer.cornerRadius = 22
        bt4.backgroundColor = Main.travelUltis.hexStringToUIColor("#3498db")
        bt4.tag = 4
        bt4.addTarget(self, action: #selector(MOEMainMapViewController.btClick), forControlEvents: .TouchUpInside)
        self.contentView.addSubview(bt4)
        
        w = 700 * widght / 960 - 20
        h = 545 * height / 1440 - 20
        frame = CGRectMake(w , h, 40, 40)
        bt5 = UIButton(frame: frame)
        bt5.setTitle("5", forState: .Normal)
        bt5.layer.cornerRadius = 22
        bt5.backgroundColor = Main.travelUltis.hexStringToUIColor(colorPurchase)
        bt5.tag = 5
        bt5.addTarget(self, action: #selector(MOEMainMapViewController.btClick), forControlEvents: .TouchUpInside)
        self.contentView.addSubview(bt5)
        
        w = 832 * widght / 960 - 20
        h = 283 * height / 1440 - 20
        frame = CGRectMake(w , h, 40, 40)
        bt6 = UIButton(frame: frame)
        bt6.setTitle("6", forState: .Normal)
        bt6.layer.cornerRadius = 22
        bt6.backgroundColor = Main.travelUltis.hexStringToUIColor(colorPurchase)
        bt6.tag = 6
        bt6.addTarget(self, action: #selector(MOEMainMapViewController.btClick), forControlEvents: .TouchUpInside)
        self.contentView.addSubview(bt6)
        
        w = 564 * widght / 960 - 20
        h = 315 * height / 1440 - 20
        frame = CGRectMake(w , h, 40, 40)
        bt7 = UIButton(frame: frame)
        bt7.setTitle("7", forState: .Normal)
        bt7.layer.cornerRadius = 22
        bt7.backgroundColor = Main.travelUltis.hexStringToUIColor(colorPurchase)
        bt7.tag = 7
        bt7.addTarget(self, action: #selector(MOEMainMapViewController.btClick), forControlEvents: .TouchUpInside)
        self.contentView.addSubview(bt7)
        
        w = 758 * widght / 960 - 20
        h = 106 * height / 1440 - 20
        frame = CGRectMake(w , h, 40, 40)
        bt8 = UIButton(frame: frame)
        bt8.setTitle("8", forState: .Normal)
        bt8.layer.cornerRadius = 22
        bt8.backgroundColor = Main.travelUltis.hexStringToUIColor(colorPurchase)
        bt8.tag = 8
        bt8.addTarget(self, action: #selector(MOEMainMapViewController.btClick), forControlEvents: .TouchUpInside)
        self.contentView.addSubview(bt8)
        
        w = 235 * widght / 960 - 20
        h = 380 * height / 1440 - 20
        frame = CGRectMake(w , h, 40, 40)
        bt9 = UIButton(frame: frame)
        bt9.setTitle("3", forState: .Normal)
        bt9.layer.cornerRadius = 22
        bt9.backgroundColor = Main.travelUltis.hexStringToUIColor(colorPurchase)
        bt9.tag = 9
        bt9.addTarget(self, action: #selector(MOEMainMapViewController.btClick), forControlEvents: .TouchUpInside)
        self.contentView.addSubview(bt9)
        
        w = 211 * widght / 960 - 20
        h = 121 * height / 1440 - 20
        frame = CGRectMake(w , h, 40, 40)
        bt10 = UIButton(frame: frame)
        bt10.setTitle("10", forState: .Normal)
        bt10.layer.cornerRadius = 22
        bt10.backgroundColor = Main.travelUltis.hexStringToUIColor(colorPurchase)
        bt10.tag = 10
        bt10.addTarget(self, action: #selector(MOEMainMapViewController.btClick), forControlEvents: .TouchUpInside)
        self.contentView.addSubview(bt10)
        
        w = 155 * widght / 960 - 20
        h = 595 * height / 1440 - 20
        frame = CGRectMake(w , h, 40, 40)
        bt11 = UIButton(frame: frame)
        bt11.setTitle("11", forState: .Normal)
        bt11.layer.cornerRadius = 22
        bt11.backgroundColor = Main.travelUltis.hexStringToUIColor(colorPurchase)
        bt11.tag = 11
        bt11.addTarget(self, action: #selector(MOEMainMapViewController.btClick), forControlEvents: .TouchUpInside)
        self.contentView.addSubview(bt11)
        
        w = 438 * widght / 960 - 20
        h = 753 * height / 1440 - 20
        frame = CGRectMake(w , h, 40, 40)
        bt12 = UIButton(frame: frame)
        bt12.setTitle("12", forState: .Normal)
        bt12.layer.cornerRadius = 22
        bt12.backgroundColor = Main.travelUltis.hexStringToUIColor(colorPurchase)
        bt12.tag = 12
        bt12.addTarget(self, action: #selector(MOEMainMapViewController.btClick), forControlEvents: .TouchUpInside)
        self.contentView.addSubview(bt12)
        
    }
    func btClick(sender:UIButton){
        btTag = sender.tag
        locationTouch.x = sender.center.x
        locationTouch.y = sender.center.y + 44
        
        var nextViewController :UIViewController!
        
        if (btTag != 3 && btTag != 4){
            if isPurchased {
                let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
                let url = NSURL(fileURLWithPath: path)
                let filePath = url.URLByAppendingPathComponent("bt1.zip").path!
                let fileManager = NSFileManager.defaultManager()
                if fileManager.fileExistsAtPath(filePath) {
                    purchased(btTag)
                } else {
                    Main.travelUltis.download(viewcontroller: self, filename: "bt1.zip")
                }
                
            } else {
                //showOptionParchase()
                showPurchase()
            }

        } else {
            let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
            let url = NSURL(fileURLWithPath: path)
            let filePath = url.URLByAppendingPathComponent("bt0.zip").path!
            let fileManager = NSFileManager.defaultManager()
            if fileManager.fileExistsAtPath(filePath) {
                var jsonMap: JsonMap!
                if btTag == 3 {
                    jsonMap = Main.travelUltis.getDataTable("bt3")
                } else if (btTag == 4) {
                    jsonMap = Main.travelUltis.getDataTable("bt4")
                } else if(btTag == 0){
                    jsonMap = Main.travelUltis.getDataTable("bt0")
                }
                Main.travelUltis.setIndexMap(index: 0)
                Main.travelUltis.setJsonMap(json: jsonMap)
                nextViewController = Main.storyBoard.instantiateViewControllerWithIdentifier("childMapViewController") as! ChildMapViewController
                let navController = UINavigationController(rootViewController: nextViewController)
                navController.transitioningDelegate = self
                navController.modalPresentationStyle = .Custom
                self.presentViewController(navController, animated:true, completion:nil)
            } else {
                Main.travelUltis.download(viewcontroller: self, filename: "bt0.zip")
            }

        }
        
    }
    func purchased(tag: Int) {
        var nextViewController: UIViewController!
        var jsonMap: JsonMap!
        if btTag == 1 {
            jsonMap = Main.travelUltis.getDataTable("bt1")
        } else if btTag == 2 {
            jsonMap = Main.travelUltis.getDataTable("bt2")
        } else if btTag == 5 {
            jsonMap = Main.travelUltis.getDataTable("bt5")
        } else if btTag == 6 {
            jsonMap = Main.travelUltis.getDataTable("bt6")
        } else if btTag == 7 {
            jsonMap = Main.travelUltis.getDataTable("bt7")
        } else if btTag == 8 {
            jsonMap = Main.travelUltis.getDataTable("bt8")
        } else if btTag == 9 {
            jsonMap = Main.travelUltis.getDataTable("bt9")
        } else if btTag == 10 {
            jsonMap = Main.travelUltis.getDataTable("bt10")
        } else if btTag == 11 {
            jsonMap = Main.travelUltis.getDataTable("bt11")
        } else if btTag == 12 {
            jsonMap = Main.travelUltis.getDataTable("bt12")
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
        Main.GAI.addScreenTracking(title: "Main Map Museum Of Ethnology")
    }
    
    @IBAction func navHomeClick(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    
}
extension MOEMainMapViewController: UIScrollViewDelegate {
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.contentView
    }
}

