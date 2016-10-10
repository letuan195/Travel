//
//  HCMFloorMapViewController.swift
//  Travel
//
//  Created by Elight on 8/30/16.
//  Copyright © 2016 Elight. All rights reserved.
//

import UIKit

class HCMFloorMapViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var titleItem: UILabel!
    
    private var items = [ItemViewPager]()
    
    private var currentPage: Int = 0 {
        didSet {
            let item = self.items[self.currentPage]
            self.titleItem.text = item.title.uppercaseString
        }
    }
    
    private var pageSize: CGSize {
        let layout = self.collectionView.collectionViewLayout as! UPCarouselFlowLayout
        var pageSize = layout.itemSize
        if layout.scrollDirection == .Horizontal {
            pageSize.width += layout.minimumLineSpacing
        }
        return pageSize
    }
    private var orientation: UIDeviceOrientation {
        return UIDevice.currentDevice().orientation
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupLayout()
        self.items = self.createItems()
        self.currentPage = 0
    }
    
    private func setupLayout() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        let layout = self.collectionView.collectionViewLayout as! UPCarouselFlowLayout
        layout.spacingMode = UPCarouselFlowLayoutSpacingMode.overlap(visibleOffset: 30)
    }
    private func createItems() -> [ItemViewPager] {
        let characters = [
            ItemViewPager(image: "lb_bt_t1", title: "Floor 1"),
            ItemViewPager(image: "lb_bt_t2", title: "Floor 2"),
            ItemViewPager(image: "lb_bt_t3", title: "Floor 3"),
            ]
        return characters
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        Main.GAI.addScreenTracking(title: "Choose Floor in HCM")
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc = segue.destinationViewController
        vc.modalPresentationStyle = .Custom
    }

    
    @IBAction func navBack(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func navInfo(sender: AnyObject) {
        Main.travelUltis.setIndexMap(index: 0)
        
        nextChildViewController()
    }
    func nextChildViewController() {
        let nextViewController = Main.storyBoard.instantiateViewControllerWithIdentifier("childMapViewController") as! ChildMapViewController
        let navController = UINavigationController(rootViewController: nextViewController)
        
        self.presentViewController(navController, animated:true, completion:nil)
    }

}
extension HCMFloorMapViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(ChooseFloorCollectionViewCell.identifier, forIndexPath: indexPath) as! ChooseFloorCollectionViewCell
        let character = items[indexPath.row]
        cell.imageView.image = UIImage(named: character.image)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        switch indexPath.row {
        case 0:
            Main.travelUltis.setIndexMap(index: 1)
            break
        case 1:
            Main.travelUltis.setIndexMap(index: 2)
            
            break
        case 2:
            Main.travelUltis.setIndexMap(index: 3)
            break
        default:
            Main.travelUltis.setIndexMap(index: 1)
            break
        }
        nextChildViewController()
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let layout = self.collectionView.collectionViewLayout as! UPCarouselFlowLayout
        let pageSide = (layout.scrollDirection == .Horizontal) ? self.pageSize.width : self.pageSize.height
        let offset = (layout.scrollDirection == .Horizontal) ? scrollView.contentOffset.x : scrollView.contentOffset.y
        currentPage = Int(floor((offset - pageSide / 2) / pageSide) + 1)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        //return CGSizeMake(collectionView.bounds.size.width - 60, collectionView.bounds.size.height - 60)
        return CGSizeMake(200,200)
    }
    
}
