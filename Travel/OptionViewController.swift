//
//  OptionViewController.swift
//  Travel
//
//  Created by Elight on 5/12/16.
//  Copyright © 2016 Elight. All rights reserved.
//

import UIKit

class OptionViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navMenu: UIBarButtonItem!
    
    private let listImage: [String] = ["option_vm", "option_food", "option_pc", "option_lb", "option_dth", "option_hl", "option_ht", "option_hidden"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame:CGRectZero)
        tableView.registerNib(UINib(nibName: "ItemOptionTableViewCell", bundle: nil), forCellReuseIdentifier: "itemOptionTableViewCell")
        
        if self.revealViewController() != nil {
            navMenu.target = self.revealViewController()
            navMenu.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        
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
        
        Main.GAI.addScreenTracking(title: "Choose your Hanoi destination")
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc = segue.destinationViewController
        vc.modalPresentationStyle = .Custom
    }
}

extension OptionViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listImage.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("itemOptionTableViewCell", forIndexPath: indexPath) as! ItemOptionTableViewCell
        
        cell.iv.image = UIImage(named: listImage[indexPath.row])
        cell.iv.backgroundColor = Main.travelUltis.hexStringToUIColor("#F44336")
        
        return cell
        
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        switch indexPath.row {
        case 0:
            //GAI
            Main.travelUltis.setHeight(height: 180.0)
            Main.GAI.addEventTracking(action: "Select place", label: "Temple of literature")
            
            let nextViewController = Main.storyBoard.instantiateViewControllerWithIdentifier("MapMainViewController") as! MapMainViewController
            self.presentViewController(nextViewController, animated:true, completion:nil)
            break
        case 1:
            //GAI
            Main.travelUltis.setHeight(height: 200.0)
            Main.GAI.addEventTracking(action: "Select place", label: "Food Tour")
            //show alert
            let nextViewController = Main.storyBoard.instantiateViewControllerWithIdentifier("fTMainMapViewController") as! FTMainMapViewController
            self.presentViewController(nextViewController, animated:true, completion:nil)
            
            break
        case 2:
            //GAI
            Main.travelUltis.setHeight(height: 220.0)
            Main.GAI.addEventTracking(action: "Select place", label: "The Old Quarter")
            //show alert
            let nextViewController = Main.storyBoard.instantiateViewControllerWithIdentifier("oQMainViewController") as! OQMainViewController
            self.presentViewController(nextViewController, animated:true, completion:nil)
            break
        case 3:
            Main.travelUltis.setHeight(height: 220.0)
            Main.GAI.addEventTracking(action: "Select place", label: "Ho Chi Minh Complex")
            let nextViewController = Main.storyBoard.instantiateViewControllerWithIdentifier("hCMMainMapViewController") as! HCMMainMapViewController
            self.presentViewController(nextViewController, animated:true, completion:nil)
            break
        case 4:
            Main.travelUltis.setHeight(height: 215.0)
            Main.GAI.addEventTracking(action: "Select place", label: "Museum of Ethnology")
            let nextViewController = Main.storyBoard.instantiateViewControllerWithIdentifier("mOEMainMapViewController") as! MOEMainMapViewController
            self.presentViewController(nextViewController, animated:true, completion:nil)
            break
            
        case 5:
            //GAI
            Main.GAI.addEventTracking(action: "Select place", label: "Hoa Lo Prison")
            let nextViewController = Main.storyBoard.instantiateViewControllerWithIdentifier("commingSoonViewController") as! CommingSoonViewController
            self.presentViewController(nextViewController, animated:true, completion:nil)
            break
        case 6:
            //GAI
            Main.GAI.addEventTracking(action: "Select place", label: "A Hidden Hanoi")
            let nextViewController = Main.storyBoard.instantiateViewControllerWithIdentifier("commingSoonViewController") as! CommingSoonViewController
            self.presentViewController(nextViewController, animated:true, completion:nil)
            break
        case 7:
            //GAI
            Main.GAI.addEventTracking(action: "Select place", label: "Imperial Citadel of Thang Long")
            let nextViewController = Main.storyBoard.instantiateViewControllerWithIdentifier("commingSoonViewController") as! CommingSoonViewController
            self.presentViewController(nextViewController, animated:true, completion:nil)
            break
        default:
            //show alert
            break
        }
    }
}
