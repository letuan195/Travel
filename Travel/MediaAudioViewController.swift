//
//  MediaAudioViewController.swift
//  Travel
//
//  Created by Elight on 5/8/16.
//  Copyright © 2016 Elight. All rights reserved.
//

import UIKit
import AVFoundation

class MediaAudioViewController: UIViewController {

    @IBOutlet weak var btPlayer: UIButton!
    
    @IBOutlet weak var lbCurrent: UILabel!
    
    @IBOutlet weak var lbTotal: UILabel!
    
    @IBOutlet weak var slider: UISlider!
    
    var timingDelegate: TimingDelegate!
    var i: Int = 0
    var j: Int = 0
    var audioPlayer: AVAudioPlayer!
    
    var playing : Bool = false //indicates if track was started playing
    var timer: NSTimer!
    
    var areaMap: Areas!
    var indexMap: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        indexMap = Main.travelUltis.getIndexMap()
        areaMap = Main.travelUltis.getJsonMap().areas[indexMap]
        
        i = 0
        j = 0
        let nameAudio = areaMap.audio
        let fileManager = NSFileManager.defaultManager()
        let directoryURL = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
        let url = directoryURL.URLByAppendingPathComponent(nameAudio)
        var data = NSData(contentsOfURL: url)
        if data == nil {
            data = Main.travelUltis.getData(name: nameAudio)
        }
        
        do {
            try! AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try! AVAudioSession.sharedInstance().setActive(true)
            
            audioPlayer = try AVAudioPlayer(data: data!, fileTypeHint: AVFileTypeWAVE)
            audioPlayer.delegate = self
        } catch {
            print("error initializing AVAudioPlayer")
            return
        }
        
        slider.continuous = false
        slider.setThumbImage(UIImage(named: "slider1"), forState: .Normal)
//        slider.setThumbImage(UIImage(named: ""), forState: .Highlighted)
        updateProgress()
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(MediaAudioViewController.updateProgress), userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillDisappear(animated: Bool) {
        if playing == true {
            audioPlayer.stop()
        }
        if timer != nil {
            timer.invalidate()
        }
        super.viewWillDisappear(animated)
    }
    
    @IBAction func silderChange(sender: AnyObject) {
        // if the track was playing store true, so we can restart playing after changing the track position
        var wasPlaying : Bool = false
        if playing == true {
            audioPlayer.pause()
            wasPlaying = true
        }
        audioPlayer.currentTime = NSTimeInterval(round(slider.value))
        if areaMap.blocks.count != 0 {
            let current_time = Int(audioPlayer.currentTime)
            if(current_time == 0){
                i = 0
                j = 0
            } else {
                outerloop:
                for (ind, items) in areaMap.blocks.enumerate() {
                    for (index, item) in items.paragraph.enumerate() {
                        if (current_time >= item.start) {
                            i = ind
                            j = index
                            break outerloop
                        }
                    }
                }
            }
        }
        
        updateProgress()
        // starts playing track again it it had been playing
        if (wasPlaying == true) {
            audioPlayer.play()
            wasPlaying = false
        }

    }
    
    @IBAction func playClick(sender: AnyObject) {
        if (playing == false) {
            btPlayer.setImage(UIImage(named: "pause"), forState: .Normal)
            audioPlayer.prepareToPlay()
            audioPlayer.play()
            btPlayer.selected = true // pause image is assigned to "selected"
            playing = true
        } else {
            btPlayer.setImage(UIImage(named: "play"), forState: .Normal)
            //updateProgress()  // update track time
            audioPlayer.pause()  // then pause
            btPlayer.selected = false  // show play image (unselected button)
            playing = false // note track has stopped playing
        }
    }
    
    // Timer delegate method that updates current time display in minutes
    func updateProgress() {
        //let total = Float(audioPlayer.duration/60)
        let current_time = Int(audioPlayer.currentTime)
        let total_time = Int(audioPlayer.duration)
        slider.minimumValue = 0.0
        slider.maximumValue = Float(total_time)
        slider.setValue(Float(audioPlayer.currentTime), animated: true)
        lbCurrent.text = NSString(format: "%02d:%02d", current_time/60,current_time%60) as String
        lbTotal.text = NSString(format: "%02d:%02d", total_time/60,total_time%60) as String
        
        if (i < areaMap.blocks.count) {
            if areaMap.blocks[i].paragraph.count == 0 {
                i = i + 1
                return
            }
            if (current_time >= areaMap.blocks[i].paragraph[j].start && current_time != 0){
                if(timingDelegate != nil){
                    timingDelegate.selecttRow(i, row: j, playing: playing)
                }
                if j == (areaMap.blocks[i].paragraph.count - 1) {
                    i = i + 1
                    j = 0
                } else {
                    j = j + 1
                }
            }
        }
    }
    func changeCurrentTime(tag: Int, row: Int) {
        i = tag
        j = row
        if(audioPlayer != nil){
            audioPlayer.currentTime = NSTimeInterval(areaMap.blocks[i].paragraph[j].start)
            updateProgress()
        }
    }
    
}
extension MediaAudioViewController: AVAudioPlayerDelegate {
    //- AVAudioPlayer delegate method - resets things when track finishe playing
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            btPlayer.selected = false
            playing = false
            i = 0
            j = 0
            btPlayer.setImage(UIImage(named: "play"), forState: .Normal)
            audioPlayer.currentTime = 0.0
        }
    }
}
