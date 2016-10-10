//
//  MapMainViewController.swift
//  Travel
//
//  Created by Elight on 5/6/16.
//  Copyright © 2016 Elight. All rights reserved.
//
import UIKit
import StoreKit

class MapMainViewController: MapViewController {

    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var navHome: UIBarButtonItem!
    
    var btInfo, bt1, bt2, bt3, bt4, bt5, bt6: UIButton!
    var btTag: Int? = 0
    var colorPurchase = "#DDDDDD"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initModel()
        initView()
        self.scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 6.0
        
    }
    func initModel() {
        Main.travelUltis.setVC(vc: self)
        code = "vm2036285"
        fileNameDownload = "vm1.zip"
        mapToUnlock = Main.UnlockTemple
        isPurchased = Main.store.isPurchasedProduct(Main.UnlockTemple)
        if isPurchased {
            colorPurchase = "#3498db"
        } else {
            colorPurchase = "#DDDDDD"
        }
    }
    
    func initView() {
        let height = UIScreen.mainScreen().bounds.height - 44
        var frame = CGRectMake(self.view.frame.size.width - 56, height/9 - 20, 40, 40)
        bt6 = UIButton(frame: frame)
        bt6.setTitle("6", forState: .Normal)
        bt6.layer.cornerRadius = 22
        bt6.backgroundColor = Main.travelUltis.hexStringToUIColor(colorPurchase)
        bt6.tag = 6
        bt6.addTarget(self, action: #selector(MapMainViewController.btClick), forControlEvents: .TouchUpInside)
        contentView.addSubview(bt6)
        
        frame = CGRectMake(self.view.frame.size.width - 56, height/3 - 20, 40, 40)
        bt5 = UIButton(frame: frame)
        bt5.tag = 5
        bt5.addTarget(self, action: #selector(MapMainViewController.btClick), forControlEvents: .TouchUpInside)
        bt5.setTitle("5", forState: .Normal)
        bt5.layer.cornerRadius = 22
        bt5.backgroundColor = Main.travelUltis.hexStringToUIColor(colorPurchase)
        contentView.addSubview(bt5)
        
        frame = CGRectMake(self.view.frame.size.width - 56, height/2 - 20, 40, 40)
        bt4 = UIButton(frame: frame)
        bt4.tag = 4
        bt4.addTarget(self, action: #selector(MapMainViewController.btClick), forControlEvents: .TouchUpInside)
        bt4.setTitle("4", forState: .Normal)
        bt4.layer.cornerRadius = 22
        bt4.backgroundColor = Main.travelUltis.hexStringToUIColor(colorPurchase)
        contentView.addSubview(bt4)
        
        frame = CGRectMake(self.view.frame.size.width - 56, 2*height/3 - 20, 40, 40)
        bt3 = UIButton(frame: frame)
        bt3.tag = 3
        bt3.addTarget(self, action: #selector(MapMainViewController.btClick), forControlEvents: .TouchUpInside)
        bt3.setTitle("3", forState: .Normal)
        bt3.layer.cornerRadius = 22
        bt3.backgroundColor = Main.travelUltis.hexStringToUIColor(colorPurchase)
        contentView.addSubview(bt3)
        
        frame = CGRectMake(self.view.frame.size.width - 56, 4*height/5 - 20, 40, 40)
        bt2 = UIButton(frame: frame)
        bt2.tag = 2
        bt2.addTarget(self, action: #selector(MapMainViewController.btClick), forControlEvents: .TouchUpInside)
        bt2.setTitle("2", forState: .Normal)
        bt2.layer.cornerRadius = 22
        bt2.backgroundColor = Main.travelUltis.hexStringToUIColor("#3498db")
        contentView.addSubview(bt2)
        
        frame = CGRectMake(self.view.frame.size.width - 56, height - 80, 40, 40)
        bt1 = UIButton(frame: frame)
        bt1.tag = 1
        bt1.setTitle("1", forState: .Normal)
        bt1.layer.cornerRadius = 22
        bt1.backgroundColor = Main.travelUltis.hexStringToUIColor("#3498db")
        bt1.addTarget(self, action: #selector(MapMainViewController.btClick), forControlEvents: .TouchUpInside)
        contentView.addSubview(bt1)
        
        frame = CGRectMake(self.view.frame.size.width - 56, height - 40, 40, 40)
        btInfo = UIButton(frame: frame)
        btInfo.tag = 0
        btInfo.setTitle("i", forState: .Normal)
        btInfo.layer.cornerRadius = 22
        btInfo.backgroundColor = Main.travelUltis.hexStringToUIColor("#3498db")
        btInfo.addTarget(self, action: #selector(MapMainViewController.btClick), forControlEvents: .TouchUpInside)
        contentView.addSubview(btInfo)

        
//        _ = NSTimer.scheduledTimerWithTimeInterval(((1.0) ), target: self, selector: #selector(self.blink), userInfo: nil, repeats: true)
        
    }
    /*var blinkStatus = false
    func blink() {
        if blinkStatus == false {
            bt1.alpha = 0
            blinkStatus = true
        }
        else {
            bt1.alpha = 1
            blinkStatus = false
        }
    }*/
    
    
    func btClick(sender:UIButton){
        btTag = sender.tag
        locationTouch.x = sender.center.x
        locationTouch.y = sender.center.y + self.contentView.frame.origin.y + 44
        
        if sender.tag > 2 {
            if isPurchased {
                let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
                let url = NSURL(fileURLWithPath: path)
                let filePath = url.URLByAppendingPathComponent("vm1.zip").path!
                let fileManager = NSFileManager.defaultManager()
                if fileManager.fileExistsAtPath(filePath) {
                    purchased(btTag!)
                } else {
                    Main.travelUltis.download(viewcontroller: self, filename: "vm1.zip")
                }

                
            } else {
                //showOptionParchase()
                showPurchase()
                
            }
        } else {
            let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
            let url = NSURL(fileURLWithPath: path)
            let filePath = url.URLByAppendingPathComponent("vm0.zip").path!
            let fileManager = NSFileManager.defaultManager()
            if fileManager.fileExistsAtPath(filePath) {
                var nextViewController: UIViewController!
                if sender.tag == 0 {
                    let jsonMap = Main.travelUltis.getDataTable("vm0")
                    Main.travelUltis.setIndexMap(index: 0)
                    Main.travelUltis.setJsonMap(json: jsonMap)
                    
                    nextViewController = Main.storyBoard.instantiateViewControllerWithIdentifier("childMapViewController") as! ChildMapViewController
                    
                    let navController = UINavigationController(rootViewController: nextViewController)
                    navController.transitioningDelegate = self
                    navController.modalPresentationStyle = .Custom
                    self.presentViewController(navController, animated:true, completion:nil)
                } else {
                    if sender.tag == 1 {
                        nextViewController = Main.storyBoard.instantiateViewControllerWithIdentifier("map1ViewController") as! Map1ViewController
                        
                    } else if sender.tag == 2 {
                        nextViewController = Main.storyBoard.instantiateViewControllerWithIdentifier("map2ViewController") as! Map2ViewController
                    }
                    nextViewController.transitioningDelegate = self
                    nextViewController.modalPresentationStyle = .Custom
                    self.presentViewController(nextViewController, animated:true, completion:nil)
                }
            } else {
                Main.travelUltis.download(viewcontroller: self, filename: "vm0.zip")
            }
            
            
        }
    }
    func purchased(tag: Int) {
        var nextViewController: UIViewController!
        switch tag {
        case 3:
            nextViewController = Main.storyBoard.instantiateViewControllerWithIdentifier("map3ViewController") as! Map3ViewController
            
            break
        case 4:
            nextViewController = Main.storyBoard.instantiateViewControllerWithIdentifier("map4ViewController") as! Map4ViewController
            break
        case 5:
            nextViewController = Main.storyBoard.instantiateViewControllerWithIdentifier("map5ViewController") as! Map5ViewController
            break
        case 6:
            nextViewController = Main.storyBoard.instantiateViewControllerWithIdentifier("map6ViewController") as! Map6ViewController
            break
        default:
            return
        }
        
        nextViewController.transitioningDelegate = self
        nextViewController.modalPresentationStyle = .Custom
        self.presentViewController(nextViewController, animated:true, completion:nil)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        Main.GAI.addScreenTracking(title: "Main Map The Literature Of Temple")
    }

    @IBAction func navHome(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
extension MapMainViewController: UIScrollViewDelegate {
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.contentView
    }
}



