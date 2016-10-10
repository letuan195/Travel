//
//  Map6ViewController.swift
//  Travel
//
//  Created by Elight on 5/7/16.
//  Copyright © 2016 Elight. All rights reserved.
//

import UIKit

class Map6ViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var contentView: UIView!
    

    var jsonMap: JsonMap!
    override func viewDidLoad() {
        super.viewDidLoad()

        jsonMap = Main.travelUltis.getDataTable("vm6")
        Main.travelUltis.setJsonMap(json: jsonMap)
        
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 6.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func bt1Click(sender: AnyObject) {
        
        Main.travelUltis.setIndexMap(index: 0)
        
        let nextViewController = Main.storyBoard.instantiateViewControllerWithIdentifier("childMapViewController") as! ChildMapViewController
        let navController = UINavigationController(rootViewController: nextViewController)
        self.presentViewController(navController, animated:true, completion:nil)
    }
    @IBAction func bt2Click(sender: AnyObject) {
        
        Main.travelUltis.setIndexMap(index: 1)
        
        let nextViewController = Main.storyBoard.instantiateViewControllerWithIdentifier("childMapViewController") as! ChildMapViewController
        let navController = UINavigationController(rootViewController: nextViewController)
        self.presentViewController(navController, animated:true, completion:nil)
    }
    @IBAction func bt3Click(sender: AnyObject) {
        
        Main.travelUltis.setIndexMap(index: 2)
        
        let nextViewController = Main.storyBoard.instantiateViewControllerWithIdentifier("childMapViewController") as! ChildMapViewController
        let navController = UINavigationController(rootViewController: nextViewController)
        self.presentViewController(navController, animated:true, completion:nil)
    }
    @IBAction func bt4Click(sender: AnyObject) {
        
        Main.travelUltis.setIndexMap(index: 3)
        
        let nextViewController = Main.storyBoard.instantiateViewControllerWithIdentifier("childMapViewController") as! ChildMapViewController
        let navController = UINavigationController(rootViewController: nextViewController)
        self.presentViewController(navController, animated:true, completion:nil)
    }
    @IBAction func macdinhchiClick(sender: AnyObject) {
        
        Main.travelUltis.setIndexMap(index: 4)
        
        let nextViewController = Main.storyBoard.instantiateViewControllerWithIdentifier("childMapViewController") as! ChildMapViewController
        let navController = UINavigationController(rootViewController: nextViewController)
        self.presentViewController(navController, animated:true, completion:nil)
    }
    @IBAction func nguyenhienClick(sender: AnyObject) {
        
        Main.travelUltis.setIndexMap(index: 5)
        
        let nextViewController = Main.storyBoard.instantiateViewControllerWithIdentifier("childMapViewController") as! ChildMapViewController
        let navController = UINavigationController(rootViewController: nextViewController)
        self.presentViewController(navController, animated:true, completion:nil)
    }
    
    @IBAction func navBack(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
        
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        Main.GAI.addScreenTracking(title: "The fifth courtyard")
    }

}
extension Map6ViewController: UIScrollViewDelegate {
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.contentView
    }
}
