//
//  GoogleAnalytisUltis.swift
//  Travel
//
//  Created by Elight on 6/1/16.
//  Copyright © 2016 Elight. All rights reserved.
//

import Foundation

public class GoogleAnalytisUltis {
    public func addScreenTracking(title name: String){
        let tracker = GAI.sharedInstance().defaultTracker
        tracker.set(kGAIScreenName, value: name)
        
        let builder = GAIDictionaryBuilder.createScreenView()
        tracker.send(builder.build() as [NSObject : AnyObject])
    }
    public func addEventTracking(action ac: String, label lb: String){
        let tracker = GAI.sharedInstance().defaultTracker
        let event = GAIDictionaryBuilder.createEventWithCategory("Action", action: ac, label: lb, value: nil)
        tracker.send(event.build() as [NSObject : AnyObject])
    }
}