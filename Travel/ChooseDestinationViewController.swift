//
//  ChooseDestinationViewController.swift
//  Travel
//
//  Created by Elight on 8/29/16.
//  Copyright © 2016 Elight. All rights reserved.
//

import UIKit

class ChooseDestinationViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var titleItem: UILabel!
    
    @IBOutlet weak var navMenu: UIBarButtonItem!
    
    
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
        
        
        if self.revealViewController() != nil {
            navMenu.target = self.revealViewController()
            navMenu.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    private func setupLayout() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        let layout = self.collectionView.collectionViewLayout as! UPCarouselFlowLayout
        layout.spacingMode = UPCarouselFlowLayoutSpacingMode.overlap(visibleOffset: 30)
    }
    private func createItems() -> [ItemViewPager] {
        let characters = [
            ItemViewPager(image: "option_vm", title: "Temple of literature"),
            ItemViewPager(image: "option_food", title: "Food Tour"),
            ItemViewPager(image: "option_pc", title: "The Old Quarter"),
            ItemViewPager(image: "option_lb", title: "Ho Chi Minh Complex"),
            ItemViewPager(image: "option_dth", title: "Museum of Ethnology"),
            ItemViewPager(image: "option_hl", title: "Hoa Lo Prison"),
            ItemViewPager(image: "option_ht", title: "A Hidden Hanoi"),
            ItemViewPager(image: "option_hidden", title: "Imperial Citadel of Thang Long"),
            ]
        return characters
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
extension ChooseDestinationViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(ChoosePlaceCollectionViewCell.identifier, forIndexPath: indexPath) as! ChoosePlaceCollectionViewCell
        let character = items[indexPath.row]
        cell.imageView.image = UIImage(named: character.image)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        switch indexPath.row {
        case 0:
            Main.travelUltis.setHeight(height: 180.0)
            Main.GAI.addEventTracking(action: "Select place", label: "Temple of literature")
            
            let nextViewController = Main.storyBoard.instantiateViewControllerWithIdentifier("MapMainViewController") as! MapMainViewController
            self.presentViewController(nextViewController, animated:true, completion:nil)
            break
        case 1:
            Main.travelUltis.setHeight(height: 200.0)
            Main.GAI.addEventTracking(action: "Select place", label: "Food Tour")
            let nextViewController = Main.storyBoard.instantiateViewControllerWithIdentifier("fTMainViewController") as! FTMainViewController
            self.presentViewController(nextViewController, animated:true, completion:nil)
            
            break
        case 2:
            Main.travelUltis.setHeight(height: 220.0)
            Main.GAI.addEventTracking(action: "Select place", label: "The Old Quarter")
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
            Main.GAI.addEventTracking(action: "Select place", label: "Hoa Lo Prison")
            let nextViewController = Main.storyBoard.instantiateViewControllerWithIdentifier("commingSoonViewController") as! CommingSoonViewController
            self.presentViewController(nextViewController, animated:true, completion:nil)
            break
        case 6:
            Main.GAI.addEventTracking(action: "Select place", label: "A Hidden Hanoi")
            let nextViewController = Main.storyBoard.instantiateViewControllerWithIdentifier("commingSoonViewController") as! CommingSoonViewController
            self.presentViewController(nextViewController, animated:true, completion:nil)
            break
        case 7:
            Main.GAI.addEventTracking(action: "Select place", label: "Imperial Citadel of Thang Long")
            let nextViewController = Main.storyBoard.instantiateViewControllerWithIdentifier("commingSoonViewController") as! CommingSoonViewController
            self.presentViewController(nextViewController, animated:true, completion:nil)
            break
        default:
            break
        }
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
