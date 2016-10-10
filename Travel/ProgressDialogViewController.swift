//
//  ProgressDialogViewController.swift
//  Travel
//
//  Created by Elight on 7/17/16.
//  Copyright © 2016 Elight. All rights reserved.
//

import UIKit
import Alamofire
import SSZipArchive

class ProgressDialogViewController: UIViewController {

    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var progressDownload: UIProgressView!
    var closeHandler: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        progressDownload.progress = 0.00
        label.text = "0%"
        download()
        
    }
    func download() {
        let destination = Alamofire.Request.suggestedDownloadDestination(directory: .DocumentDirectory, domain: .UserDomainMask)
        let linkDownload = "http://lanamate.com/public/api/v0/" + Main.travelUltis.getFilename()
        Alamofire.download(.GET, linkDownload, destination: destination)
            .progress { bytesRead, totalBytesRead, totalBytesExpectedToRead in
                print(totalBytesRead)
                
                dispatch_async(dispatch_get_main_queue()) {
                    let progress = Float(totalBytesRead) / Float(totalBytesExpectedToRead)
                    self.progressDownload.progress = progress
                    self.label.text = String(Int(progress * 100)) + "%"
                }
            }
            .response { _ , _ , data, error in
                if let error = error {
                    print(error)
                    //Main.travelUltis.showAlert(viewcontroller: self, title: "Error", message: "//")
                } else {
                    let fileManager = NSFileManager.defaultManager()
                    let directoryURL = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
                    let url = directoryURL.URLByAppendingPathComponent(Main.travelUltis.getFilename())
                    
                    //NSSearchPathForDirectoriesInDomains(.CachesDirectory, .UserDomainMask, true)[0]

                    let success = SSZipArchive.unzipFileAtPath(url.path, toDestination: directoryURL.path)
                    if success {
                        self.closeHandler?()
                    } else {
                        print(directoryURL.path)
                    }
                    
                }
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
extension ProgressDialogViewController: PopupContentViewController {
    class func instance() -> ProgressDialogViewController {
        let storyboard = UIStoryboard(name: "ProgressDialogDownload", bundle: nil)
        return storyboard.instantiateViewControllerWithIdentifier("progressDialogViewController") as! ProgressDialogViewController
    }
    
    func sizeForPopup(popupController: PopupController, size: CGSize, showingKeyboard: Bool) -> CGSize {
        return CGSizeMake(280,120)
    }
}
