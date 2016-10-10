//
//  Main.swift
//  Travel
//
//  Created by Elight on 5/6/16.
//  Copyright © 2016 Elight. All rights reserved.
//

import Foundation
public struct Main {
    //storyboard
    public static let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    
    // MARK: - Temple
    public static let travelUltis = TravelUltis()
    public static let GAI = GoogleAnalytisUltis()
    
    // MARK: - IAP
    private static let Prefix = "com.elitetravel.travelmate."
    public static let UnlockTemple = Main.Prefix + "unlock"
    public static let UnlockOldQuarter = Main.Prefix + "oldquarter"
    public static let UnlockHCM = Main.Prefix + "hcm"
    public static let UnlockBTDTH = Main.Prefix + "btdth"
    public static let UnlockFoodTour = Main.Prefix + "foodtour"
    private static let productIdentifiers: Set<String> = [Main.UnlockTemple, Main.UnlockOldQuarter, Main.UnlockHCM, Main.UnlockBTDTH, Main.UnlockFoodTour]
    
    public static let store = IAPHelper(productsID: productIdentifiers)
}