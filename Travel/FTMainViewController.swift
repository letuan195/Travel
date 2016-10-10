//
//  FTMainViewController.swift
//  Travel
//
//  Created by Elight on 8/30/16.
//  Copyright © 2016 Elight. All rights reserved.
//

import UIKit

class FTMainViewController: MapViewController {

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

        initModel()
        
        self.setupLayout()
        self.items = self.createItems()
        
        self.currentPage = 0
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
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    override func viewWillAppear(animated: Bool) {
        Main.GAI.addScreenTracking(title: "Food Choose")
    }

    @IBAction func navBack(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    private func setupLayout() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        let layout = self.collectionView.collectionViewLayout as! UPCarouselFlowLayout
        layout.spacingMode = UPCarouselFlowLayoutSpacingMode.overlap(visibleOffset: 30)
    }

    private func createItems() -> [ItemViewPager] {
        let characters = [
            ItemViewPager(image: "ft_info", title: "General Infomation"),
            ItemViewPager(image: "Bun Cha", title: "Bun Cha"),
            ItemViewPager(image: "Nom du du", title: "Nom du du"),
            ItemViewPager(image: "Banh Cuon", title: "Banh Cuon"),
            ItemViewPager(image: "Spring rolls and Banh Goi", title: "Spring rolls and Banh Goi"),
            ItemViewPager(image: "Jackfruit Yogurt", title: "Sua Chua Mit"),
            ItemViewPager(image: "Egg Coffee - Ca phe trung", title: "Cafe Trung"),
            ItemViewPager(image: "Lemon Tea - Tra Chanh", title: "Tra Chanh"),
            ItemViewPager(image: "Bo Bia", title: "Bo Bia"),
            ]
        return characters
    }
    

}
extension FTMainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(ChooseFoodCollectionViewCell.identifier, forIndexPath: indexPath) as! ChooseFoodCollectionViewCell
        let character = items[indexPath.row]
        cell.imageView.image = UIImage(named: character.image)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.row > 2 && isPurchased == false {
            let popup = PopupController
                .create(self)
                .customize([
                    PopupCustomOption.Scrollable(false),
                    PopupCustomOption.DismissWhenTaps(false)
                    ])
            
            let container = RateViewController.instance()
            popup.show(container)
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

