//
//  Map3ViewController.swift
//  Travel
//
//  Created by Elight on 5/7/16.
//  Copyright © 2016 Elight. All rights reserved.
//

import UIKit

class Map3ViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var contentView: UIView!
    
    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

    var jsonMap: JsonMap!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        jsonMap = Main.travelUltis.getDataTable("vm3")
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
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        Main.GAI.addScreenTracking(title: "The second courtyard")
    }
    @IBAction func navBack(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
extension Map3ViewController: UIScrollViewDelegate {
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.contentView
    }
}
