//
//  TravelUltis.swift
//  Travel
//
//  Created by Elight on 5/6/16.
//  Copyright © 2016 Elight. All rights reserved.
//

import Foundation
import SystemConfiguration
import Alamofire

public class TravelUltis {
    
    private var VC: UIViewController? = nil
    private var jsonMap: JsonMap!
    private var indexMap: Int!
    private var heighImage: CGFloat!
    private var fileName: String?
  
  // MARK: - get data with extension
    public func getData(name name: String) -> NSData{
        var array = name.componentsSeparatedByString(".")
        
        let url = NSBundle.mainBundle().URLForResource(array[0], withExtension: array[1])
        if url == nil {
            print("file name is wrong")
            return NSData()
        }
        
        return NSData(contentsOfURL: url!)!
    }
  
    public func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet() as NSCharacterSet).uppercaseString
    
        if (cString.hasPrefix("#")) {
            cString = cString.substringFromIndex(cString.startIndex.advancedBy(1))
        }
    
        if ((cString.characters.count) != 6) {
            return UIColor.grayColor()
        }
    
        var rgbValue:UInt32 = 0
        NSScanner(string: cString).scanHexInt(&rgbValue)
    
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    public func showAlert(viewcontroller viewcontroller: UIViewController,title: String, message: String){
        let alert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let okAction: UIAlertAction = UIAlertAction(title: "OK", style: .Cancel) { action -> Void in
            //Do some other stuff
        }
        alert.addAction(okAction)
        viewcontroller.self.presentViewController(alert, animated: true, completion: nil)
    }
    
    public func setVC(vc vc: UIViewController) {
        self.VC = vc
    }
    public func getVC() -> UIViewController {
        return self.VC!
    }
    
    public func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(&zeroAddress) {
            SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0))
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    
    //get screen
    public func fixScreen(size: CGFloat, isHorization: Bool) -> CGFloat
    {
        var realize: CGFloat!
        if(isHorization)
        {
            realize = UIScreen.mainScreen().bounds.size.width * size / 320
        }
        else
        {
            realize = UIScreen.mainScreen().bounds.size.height * size / 568
        }
        return realize;
    }
    
    public func getHeightImage() -> CGFloat{
        return fixScreen(self.getHeight(), isHorization: false)
    }
    
    //get json
    public func getDataTable(name: String) -> JsonMap {
        var url = NSBundle.mainBundle().URLForResource(name, withExtension: "json")
        if url == nil {
            let fileManager = NSFileManager.defaultManager()
            let directoryURL = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
            url = directoryURL.URLByAppendingPathComponent(name + ".json")
        }
        let data = NSData(contentsOfURL: url!)!
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
            if let dictionary = json as? [String: AnyObject] {
                return readObjectJson(dictionary)
            }
        } catch {
            print("wrong while tranform json to data")
        }
        return JsonMap()
    }
    public func readObjectJson(object: [String: AnyObject]) -> JsonMap {
        guard let name = object["name"] as? String,
            let areas = object["areas"] as? [[String: AnyObject]] else {
                return JsonMap()
        }
        
        
        var listArea: [Areas] = []
        for area in areas {
            guard let name = area["name"] as? String,
            let audio = area["audio"] as? String,
                let blocks = area["blocks"] as? [[String: AnyObject]] else { break }
            
            var listBlock: [Blocks] = []
            for block in blocks {
                guard let picture = block["picture"] as? String,
                    let paragraph = block["paragraph"] as? [[String: AnyObject]] else { break }
                
                var listPara: [Paragraph] = []
                for item in paragraph {
                    guard let text = item["text"] as? String,
                        let start = item["start"] as? Int else { break }
                    let para = Paragraph(text: text, start: start)
                    listPara.append(para)
                }
                let blockItem = Blocks(picture: picture, paragraphs: listPara)
                listBlock.append(blockItem)
            }
            let areaItem = Areas(name: name, audio: audio, blocks: listBlock)
            listArea.append(areaItem)
        }
        let jsonMap = JsonMap(name: name, areas: listArea)
        return jsonMap
    }
    
    public func isValidEmail(email email: String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluateWithObject(email)
    }
    
    public func getJsonMap() -> JsonMap{
        return self.jsonMap
    }
    public func setJsonMap(json jsonMap: JsonMap){
        self.jsonMap = jsonMap
    }
    public func getIndexMap() -> Int {
        return self.indexMap
    }
    public func setIndexMap(index index: Int){
        self.indexMap = index
    }
    public func getHeight() -> CGFloat {
        return heighImage
    }
    public func setHeight(height h: CGFloat){
        self.heighImage = h
    }
    public func setFilename(filename fileName: String){
        self.fileName = fileName
    }
    public func getFilename() -> String{
        if let fileName = self.fileName {
            return fileName
        }
        return ""
    }
    
    public func download(viewcontroller vc: UIViewController, filename: String) {
        Main.travelUltis.setFilename(filename: filename)
        //show dialog dowload
        let popup = PopupController
            .create(vc.self)
            .customize([
                PopupCustomOption.Scrollable(false),
                PopupCustomOption.DismissWhenTaps(false)
                ])
        
        let container = ProgressDialogViewController.instance()
        container.closeHandler = { _ in
            popup.dismiss()
            Main.travelUltis.showAlert(viewcontroller: vc, title: "Success", message: "Click again to continue!")
        }
        popup.show(container)
    }
    
}