//
//  FTDetailsViewController.swift
//  Travel
//
//  Created by Elight on 8/5/16.
//  Copyright © 2016 Elight. All rights reserved.
//

import UIKit

class FTDetailsViewController: UIViewController {

    @IBOutlet weak var navTitle: UINavigationItem!
    
    
    var jsonMap: JsonMap!
    var titles = ["What is it?","How to eat?","Where?"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initilizaModel()
        initilizaView()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    override func viewWillAppear(animated: Bool) {
        Main.GAI.addScreenTracking(title: jsonMap.name)
    }

    @IBAction func navBackClick(sender: AnyObject) {
        if jsonMap.areas[0].audio == "ft21.mp3" {
            let showRate = Main.travelUltis.getVC() as! ShowRateDelegate
            showRate.onShow()
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func initilizaModel() {
        jsonMap = Main.travelUltis.getJsonMap()
    }
    
    func initilizaView() {
        let width: CGFloat = UIScreen.mainScreen().bounds.size.width
        let height: CGFloat = UIScreen.mainScreen().bounds.size.height
        
        navTitle.title = jsonMap.name
        
        //view pager
        let options = ViewPagerOptions()
        options.fitAllTabsInView = true
        options.isTabViewHighlightAvailable = true
        options.tabViewBackgroundColor = Main.travelUltis.hexStringToUIColor("#f44336")
        options.tabViewHighlightColor = Main.travelUltis.hexStringToUIColor("#f44336")
        options.tabIndicatorViewBackgroundColor = Main.travelUltis.hexStringToUIColor("#ffffff")
        
        let viewPager = ViewPagerController()
        viewPager.options = options
        viewPager.dataSource = self
        viewPager.delegate = self
        let frameViewPager = CGRect(x: 0, y: 44, width: width, height: height - 44)
        viewPager.view.frame = frameViewPager
        
        self.addChildViewController(viewPager)
        self.view.addSubview(viewPager.view)
        viewPager.didMoveToParentViewController(self)
    }
}
extension FTDetailsViewController: ViewPagerControllerDataSource
{
    
    func numberOfPages() -> Int
    {
        return titles.count
    }
    
    func viewControllerAtPosition(position:Int) -> UIViewController
    {
        Main.travelUltis.setIndexMap(index: position)
        let nextViewController = Main.storyBoard.instantiateViewControllerWithIdentifier("childMapViewController") as! ChildMapViewController
        //let navController = UINavigationController(rootViewController: nextViewController)
        return nextViewController
    }
    
    func pageTitles() -> [String]
    {
        return titles
    }
    
}

extension FTDetailsViewController: ViewPagerControllerDelegate
{
    func willMoveToViewControllerAtIndex(index:Int)
    {
        print("Will Move To VC: \(index)")
    }
    
    func didMoveToViewControllerAtIndex(index:Int)
    {
        Main.travelUltis.setIndexMap(index: index)
    }
    
    
    
}
