//
//  FTMainMapViewController.swift
//  Travel
//
//  Created by Elight on 7/29/16.
//  Copyright © 2016 Elight. All rights reserved.
//
import StoreKit
import UIKit

class FTMainMapViewController: MapViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let listImage: [String] = ["ft_info", "Bun Cha", "Nom du du", "Banh Cuon", "Spring rolls and Banh Goi", "Jackfruit Yogurt", "Egg Coffee - Ca phe trung", "Lemon Tea - Tra Chanh", "Bo Bia"]
    let listTitle: [String] = ["General Infomation", "Bun Cha", "Banh Cuon", "Banh Goi", "Bo Bia", "Cafe Trung", "Nom", "Sua Chua Mit", "Tra Chanh"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initModel()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.registerNib(UINib(nibName: "FoodTourItemTableViewCell", bundle: nil), forCellReuseIdentifier: "foodTourItemTableViewCell")
        let width = UIScreen.mainScreen().bounds.size.width
        tableView.rowHeight = 190 * 325 / width + 76
        tableView.contentInset = UIEdgeInsetsMake(-36, 0, 0, 0)
        
    }
    func initModel() {
        Main.travelUltis.setVC(vc: self)
        code = "ft2036285"
        fileNameDownload = "ft1.zip"
        mapToUnlock = Main.UnlockFoodTour
        isPurchased = Main.store.isPurchasedProduct(Main.UnlockFoodTour)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func navHomeClick(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    override func viewWillAppear(animated: Bool) {
        Main.GAI.addScreenTracking(title: "Food Choose")
    }

}
extension FTMainMapViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listImage.count;
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("foodTourItemTableViewCell", forIndexPath: indexPath) as! FoodTourItemTableViewCell
        cell.lb.text = listTitle[indexPath.row]
        cell.iv.image = UIImage(named: listImage[indexPath.row])
        
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.row > 2 && isPurchased == false {
           //showOptionParchase()
            showPurchase()
        } else if indexPath.row > 2 && isPurchased {
            let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
            let url = NSURL(fileURLWithPath: path)
            let filePath = url.URLByAppendingPathComponent("ft1.zip").path!
            let fileManager = NSFileManager.defaultManager()
            if fileManager.fileExistsAtPath(filePath) {
                nextScreen(indexPath.row)
            } else {
                Main.travelUltis.download(viewcontroller: self, filename: "ft1.zip")
            }
        } else {
            let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
            let url = NSURL(fileURLWithPath: path)
            let filePath = url.URLByAppendingPathComponent("ft0.zip").path!
            let fileManager = NSFileManager.defaultManager()
            if fileManager.fileExistsAtPath(filePath) {
                nextScreen(indexPath.row)
            } else {
                Main.travelUltis.download(viewcontroller: self, filename: "ft0.zip")
            }
        }
        
        
        
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func nextScreen(row: Int) {
        var jsonMap: JsonMap!
        let jsonName = "ft" + String(row)
        jsonMap = Main.travelUltis.getDataTable(jsonName)
        Main.travelUltis.setJsonMap(json: jsonMap)
        
        var nextViewController: UIViewController!
        if row == 0 {
            nextViewController = Main.storyBoard.instantiateViewControllerWithIdentifier("childMapViewController") as! ChildMapViewController
            Main.travelUltis.setIndexMap(index: 0)
            let navController = UINavigationController(rootViewController: nextViewController)
            navController.transitioningDelegate = self
            navController.modalPresentationStyle = .Custom
            self.presentViewController(navController, animated:true, completion:nil)
        } else {
            nextViewController = Main.storyBoard.instantiateViewControllerWithIdentifier("fTDetailsViewController") as! FTDetailsViewController
            self.presentViewController(nextViewController, animated:true, completion:nil)
        }
        
    }
}
