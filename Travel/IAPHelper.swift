//
//  IAPHelper.swift
//  Travel
//
//  Created by Elight on 5/6/16.
//  Copyright © 2016 Elight. All rights reserved.
//

import Foundation
import StoreKit
public typealias ProductIdentifier = String
public typealias ProductRequestCompletionHandler = (success: Bool, products: [SKProduct]?) -> Void
public class IAPHelper: NSObject {
    private let productIdentifiers: Set<ProductIdentifier>
    private var purchasedProductIdentifiers = Set<ProductIdentifier>()
    
    private var productsRequest: SKProductsRequest?
    private var productsRequestCompletionHandler: ProductRequestCompletionHandler?
    static let IAPHelperPurchaseNotification = "IAPHelperPurchaseNotification"
    
    public init(productsID: Set<ProductIdentifier>){
        self.productIdentifiers = productsID
        
        for productIdentifier in productsID {
            
            let purchased = NSUserDefaults.standardUserDefaults().boolForKey(productIdentifier)
            if purchased {
                purchasedProductIdentifiers.insert(productIdentifier)
                print("Previously purchased: \(productIdentifier)")
            } else {
                print("Not purchased: \(productIdentifier)")
            }
        }
        
        super.init()
        SKPaymentQueue.defaultQueue().addTransactionObserver(self)
    }
    
    public func insertPurchased(identifier: String){
        purchasedProductIdentifiers.insert(identifier)
    }
        
}

// MARK: - StoreKit API
extension IAPHelper {
    public func requestProducts(completionHandler: ProductRequestCompletionHandler){
        productsRequest?.cancel()
        productsRequestCompletionHandler = completionHandler
        
        productsRequest = SKProductsRequest(productIdentifiers: productIdentifiers)
        productsRequest?.delegate = self
        productsRequest?.start()
    }
    
    public func buyProduct(product: SKProduct){
        print("buying \(product.productIdentifier)...")
        let payment = SKPayment(product: product)
        SKPaymentQueue.defaultQueue().addPayment(payment)
    }
    
    public func isPurchasedProduct(productIdentifier: ProductIdentifier) -> Bool{
        return purchasedProductIdentifiers.contains(productIdentifier)
    }
    
    public func canMakePayments() -> Bool {
        return SKPaymentQueue.canMakePayments()
    }
    
    public func restorePurchases(){
        SKPaymentQueue.defaultQueue().restoreCompletedTransactions()
    }
}

// MARK: - SKProductsRequestDelegate
extension IAPHelper: SKProductsRequestDelegate {
    public func productsRequest(request: SKProductsRequest, didReceiveResponse response: SKProductsResponse) {
        print("Load list products...")
        let products = response.products
        productsRequestCompletionHandler?(success: true, products: products)
        clearRequestAndHandler()
        
        for p in products {
            print("product: \(p.productIdentifier)")
        }
        
    }
    
    public func request(request: SKRequest, didFailWithError error: NSError) {
        print("Failed to load list of products.")
        print("Error: \(error.localizedDescription)")
        productsRequestCompletionHandler?(success: false, products: nil)
        clearRequestAndHandler()
    }
    
    private func clearRequestAndHandler(){
        productsRequest = nil
        productsRequestCompletionHandler = nil
    }
}

// MARK: - SKPaymentTransactionObserver

extension IAPHelper: SKPaymentTransactionObserver {
    public func paymentQueue(queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .Purchased:
                completeTransaction(transaction)
                break
            case .Restored:
                restoreTransaction(transaction)
                break
            case .Failed:
                failedTransaction(transaction)
                break
            case .Deferred:
                break
            case .Purchasing:
                break
            }
        }
    }
    
    public func paymentQueueRestoreCompletedTransactionsFinished(queue: SKPaymentQueue) {
        for transaction in queue.transactions {
            let t: SKPaymentTransaction = transaction as SKPaymentTransaction
            let prodcutID = t.payment.productIdentifier as String
            switch prodcutID {
            case Main.UnlockTemple:
                //restorePurchases()
                break
            default:
                break
            }
        }
    }
    
    private func completeTransaction(transaction: SKPaymentTransaction){
        print("complete transaction...")
        deliverPurchaseNotificatioForIdentifier(transaction.payment.productIdentifier)
        SKPaymentQueue.defaultQueue().finishTransaction(transaction)
    }
    private func restoreTransaction(transaction: SKPaymentTransaction){
        guard let productIdentifier = transaction.originalTransaction?.payment.productIdentifier else {return}
        
        print("restore transaction \(productIdentifier)...")
        deliverPurchaseNotificatioForIdentifier(transaction.payment.productIdentifier)
        SKPaymentQueue.defaultQueue().finishTransaction(transaction)
    }
    
    private func failedTransaction(transaction: SKPaymentTransaction){
        print("failedTransaction...")
        if transaction.error!.code != SKErrorCode.PaymentCancelled.rawValue {
            print("Transaction Error: \(transaction.error?.localizedDescription)")
        }
        Main.travelUltis.showAlert(viewcontroller: Main.travelUltis.getVC(), title: "Error", message: "Check apple id again!")
        SKPaymentQueue.defaultQueue().finishTransaction(transaction)
    }
    
    private func deliverPurchaseNotificatioForIdentifier(identifier: String?){
        guard let identifier = identifier else {return}
        
        self.insertPurchased(identifier)
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: identifier)
        NSUserDefaults.standardUserDefaults().synchronize()
        
        let temp = Main.travelUltis.getVC() as! MapViewController
        temp.isPurchased = true
        
        var fileName: String!
        if identifier == Main.UnlockTemple {
            fileName = "vm1.zip"
        } else if (identifier == Main.UnlockOldQuarter) {
            fileName = "pc1.zip"
        } else if (identifier == Main.UnlockHCM) {
            fileName = "lb1.zip"
        } else if (identifier == Main.UnlockBTDTH) {
            fileName = "bt1.zip"
        } else if (identifier == Main.UnlockFoodTour) {
            fileName = "ft1.zip"
        } else {
            //not exits
            fileName = "vm1.zip"
        }
        Main.travelUltis.download(viewcontroller: Main.travelUltis.getVC(), filename: fileName)
        
        //NSNotificationCenter.defaultCenter().postNotificationName(IAPHelper.IAPHelperPurchaseNotification, object: identifier)
    }
}




