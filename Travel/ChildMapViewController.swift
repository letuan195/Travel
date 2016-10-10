//
//  ChildMapViewController.swift
//  Travel
//
//  Created by Elight on 5/8/16.
//  Copyright © 2016 Elight. All rights reserved.
//

import UIKit
import Gifu


class ChildMapViewController: UIViewController {
    
    @IBOutlet weak var containerMedia: UIView!
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var listTableView: [UITableView] = []
    var mediaAudioVC: MediaAudioViewController!
    var jsonMap: JsonMap!
    var indexMap: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initModel()
        initView()
        
        scrollView.delegate = self
        scrollView.maximumZoomScale = 6.0
        scrollView.minimumZoomScale = 1.0
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let vc = segue.destinationViewController as? MediaAudioViewController
            where segue.identifier == "media" {
            self.mediaAudioVC = vc
            mediaAudioVC.timingDelegate = self
            
        }
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let screen = jsonMap.areas[indexMap].name
        Main.GAI.addScreenTracking(title: screen)
        
        if self.navigationController != nil {
            let back: UIBarButtonItem = UIBarButtonItem()
            back.image = UIImage(named: "back")
            back.target = self
            back.action = #selector(ChildMapViewController.backParent)
            back.tintColor = Main.travelUltis.hexStringToUIColor("#f44336")
            
            self.navigationItem.leftBarButtonItem = back
            self.navigationItem.title = jsonMap.name
        }
        
        
    }
    
    func backParent() {
        if(jsonMap.areas[0].audio == "lb20.mp3" || jsonMap.areas[0].audio == "bt04.mp3"){
            let showRate = Main.travelUltis.getVC() as! ShowRateDelegate
            showRate.onShow()
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func initModel() {
        jsonMap = Main.travelUltis.getJsonMap()
        indexMap = Main.travelUltis.getIndexMap()
    }
    
    func initView() {
        let width: CGFloat = UIScreen.mainScreen().bounds.size.width
        let height: CGFloat = UIScreen.mainScreen().bounds.size.height
        
        let heightImage = Main.travelUltis.getHeightImage()
        
        var pointY = contentView.frame.origin.y
        
        //label
        let label = UILabel()
        let framelb = CGRect(x: 0, y: pointY, width: width, height: 48)
        label.frame = framelb
        label.font = UIFont(name: "Roboto-Regular", size: 24.0)
        label.font = UIFont.boldSystemFontOfSize(24.0)
        label.textAlignment = NSTextAlignment.Center
        label.numberOfLines = 0
        label.text = jsonMap.areas[indexMap].name
        contentView.addSubview(label)
        
        pointY = pointY + 48
        
        
        
        for (index, item) in jsonMap.areas[indexMap].blocks.enumerate() {
            if item.picture != "" {
                let image = AnimatableImageView()
                let frameImage = CGRect(x: 12, y: pointY, width: width - 24, height: heightImage)
                image.frame = frameImage
                image.contentMode = .ScaleAspectFit
                
                let fileManager = NSFileManager.defaultManager()
                let directoryURL = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
                let url = directoryURL.URLByAppendingPathComponent(item.picture)
                let dataUrl = NSData(contentsOfURL: url)
                if let data = dataUrl {
                    image.animateWithImageData(data)
                } else {
                    image.animateWithImage(named: item.picture)
                }
                
                pointY = pointY + 12 + frameImage.size.height
                contentView.addSubview(image)
            } else {
                pointY = pointY + 12
            }
            
            if item.paragraph.count != 0 {
                let tableview: UITableView  = UITableView()
                tableview.tag = index
                tableview.delegate = self
                tableview.dataSource = self
                tableview.registerNib(UINib(nibName: "ItemTimingTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
                tableview.estimatedRowHeight = 44.0
                tableview.rowHeight = UITableViewAutomaticDimension
                tableview.allowsSelection = true
                tableview.alwaysBounceVertical = true
                let frameTable = CGRect(x: 0, y: pointY, width: width, height: CGFloat(item.paragraph.count * 60))
                tableview.frame = frameTable
                contentView.addSubview(tableview)
                listTableView.append(tableview)
                
                self.contentView.layoutIfNeeded()
                tableview.frame.size.height = tableview.contentSize.height
                self.contentView.updateConstraints()
                
                pointY = pointY + 12 + tableview.frame.size.height
                
            }
        }
        
        
        if self.navigationController == nil {
            pointY = pointY + heightImage
        }
        self.scrollView.layoutIfNeeded()
        let heightConstraint = NSLayoutConstraint(item: contentView, attribute: .Height, relatedBy: .Equal, toItem: self.view, attribute: .Height, multiplier: 1.0, constant: pointY - height)
        self.view.addConstraint(heightConstraint)
        self.contentView.frame.size.height = pointY
        self.scrollView.updateConstraints()
        
        print("\(pointY) : \(contentView.frame.size.height)")
    }
    
    
}


extension ChildMapViewController: TimingDelegate {
    func selecttRow(tag: Int, row: Int, playing: Bool) {
        
        //|| infoChild == nil
        if (playing == false || tag > jsonMap.areas[indexMap].blocks.count) {
            return
        }
        
        for (index, item) in jsonMap.areas[indexMap].blocks.enumerate() {
            if item.paragraph.count == 0 {
                continue
            } else {
                if(index != tag){
                    if listTableView[index].indexPathForSelectedRow != nil {
                        listTableView[index].deselectRowAtIndexPath(listTableView[index].indexPathForSelectedRow!, animated: true)
                    }
                }
            }
        }
        
        let rowToSelect:NSIndexPath = NSIndexPath(forRow: row, inSection: 0)
        listTableView[tag].selectRowAtIndexPath(rowToSelect, animated: true, scrollPosition: .Bottom)
        
        //        if playing {
        //            var rect = listTableView[tag].frame
        //            rect.origin.x = 0
        //            rect.origin.y += CGFloat(row*44)
        //            rect.size.height = 300
        //            scrollView.scrollRectToVisible(rect, animated: true)
        //        }
    }
}
extension ChildMapViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jsonMap.areas[indexMap].blocks[tableView.tag].paragraph.count
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        mediaAudioVC.changeCurrentTime(tableView.tag, row: indexPath.row)
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //init cell
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! ItemTimingTableViewCell
        
        let paragraphStyle = NSMutableParagraphStyle()
        
        paragraphStyle.alignment = NSTextAlignment.Justified
        
        paragraphStyle.firstLineHeadIndent = 0.01
        
        paragraphStyle.paragraphSpacingBefore = 10.0
        
        cell.lb.attributedText = NSAttributedString(string: jsonMap.areas[indexMap].blocks[tableView.tag].paragraph[indexPath.row].text)
        
        let mutableAttrStr = NSMutableAttributedString(attributedString: cell.lb.attributedText!)
        
        mutableAttrStr.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, mutableAttrStr.length))
        
        //cell.lb.lineBreakMode = .ByWordWrapping
        cell.lb.numberOfLines = 0
        cell.lb.attributedText = mutableAttrStr
        //cell.lb.text = jsonMap.areas[indexMap].blocks[tableView.tag].paragraph[indexPath.row].text
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = Main.travelUltis.hexStringToUIColor("#2196f3")
        cell.selectedBackgroundView = backgroundView
        
        return cell
        
    }
}
extension ChildMapViewController: UIScrollViewDelegate {
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.contentView
    }
}
