//
//  IAPHelper.swift
//  Extension
//
//  Created by Naveen Kumar on 25/02/23.
//

import Foundation
import SwiftyStoreKit
import SVProgressHUD

struct IAPPlanResult{
    var productId: String
    var quantity: Int
    var needsFinishTransaction: Bool
    var transactionId: String
    var localizedDescription: String
    var price: NSDecimalNumber
    var localizedPrice: String
}

 protocol InAppPurchaseDelegate: AnyObject {
    func restoreDidSucceed(_ transactionId: String)
    func purchaseDidSucceed(plan: IAPPlanResult)
    func nothingToRestore()
    func paymentCancelled()
    func errorAlert(_ errMsg: String)
    func returnIAPlocalPrice(localPrice: String)
}
extension InAppPurchaseDelegate{
    func restoreDidSucceed(_ transactionId: String){}
    func purchaseDidSucceed(plan: IAPPlanResult){}
    func nothingToRestore(){}
    func paymentCancelled(){}
    func errorAlert(_ errMsg:String){}
    func returnIAPlocalPrice(localPrice: String){}

}


class IAPHelper : NSObject {
    
    enum IAPSubscriptionTypes: String{
        case nonConsumableProduct = "com.msa.affirmation.app.msapurchase"
        case subsciptionYearly = "com.msa.affirmation.1m"
    }
    
    public static var shared : IAPHelper? = IAPHelper()
    private let sharedSecret = "b0c7dc3d15b34fd687d32b8754dc5097"
    private override init(){}
    
    weak var delegate: InAppPurchaseDelegate?

    func getIAPlocalPrice(productID: IAPSubscriptionTypes){
        
        SwiftyStoreKit.retrieveProductsInfo([productID.rawValue]) { [self] result in
            if let product = result.retrievedProducts.first {
                let priceString = product.localizedPrice!
                print("Product: \(product.localizedDescription), price: \(priceString)")
                
                delegate?.returnIAPlocalPrice(localPrice: priceString)
                
            }
            else if let invalidProductId = result.invalidProductIDs.first {
                print("Invalid product identifier: \(invalidProductId)")
            }
            else {
                print("Error: \(String(describing: result.error))")
            }
        }
        
    }
    
    func restorePurchase() {
        SVProgressHUD.show()
        SwiftyStoreKit.restorePurchases(atomically: true) { [self] results in
            if (results.restoreFailedPurchases.count>0) {
                print("Restore Failed: \(results.restoreFailedPurchases)")
                delegate?.errorAlert(GConstant.kAPIError)
            }
            else if (results.restoredPurchases.count>0) {
                print("Restore Success: \(results.restoredPurchases.first?.originalTransaction?.transactionIdentifier)")
                guard let transactionId = results.restoredPurchases.first?.originalTransaction?.transactionIdentifier else { return }
                delegate?.restoreDidSucceed(transactionId)
            }
            else {
                // Nothing to restore
                delegate?.nothingToRestore()
            }
        }
    }
    
    func verifyPurchase(){
        let appleValidator = AppleReceiptValidator(service: .sandbox, sharedSecret: self.sharedSecret)
        SwiftyStoreKit.verifyReceipt(using: appleValidator, forceRefresh: false) { result in
            switch result {
            case .success(let receipt):
                print("Verify receipt success: \(receipt)")
            case .error(let error):
                print("Verify receipt failed: \(error)")
            }
        }
    }
    
    func purchase(productID: IAPSubscriptionTypes) {
        print("productzId:-",productID.rawValue)
        SwiftyStoreKit.purchaseProduct(productID.rawValue, atomically: true) { [self] result in
            switch result {
            case .success(let value):
                print(value)
                let plan = IAPPlanResult(productId: value.productId, quantity: value.quantity, needsFinishTransaction: value.needsFinishTransaction, transactionId: value.transaction.transactionIdentifier ?? "", localizedDescription: value.product.localizedDescription, price: value.product.price, localizedPrice: value.product.localizedPrice ?? "")
                delegate?.purchaseDidSucceed(plan: plan)
            case .error(let error):
                switch error.code {
                case .unknown:
                    delegate?.errorAlert("Unknown error. Please contact support")
                    print("Unknown error. Please contact support")
                case .clientInvalid:
                    delegate?.errorAlert("Not allowed to make the payment")
                    print("Not allowed to make the payment")
                case .paymentCancelled:
                    delegate?.errorAlert("Payment has cancelled")
                    delegate?.paymentCancelled()
                case .paymentInvalid:
                    delegate?.errorAlert("The purchase identifier is invalid")
                    print("The purchase identifier was invalid \(error.localizedDescription)")
                case .paymentNotAllowed:
                    delegate?.errorAlert("The device is not allowed to make the payment")
                    print("The device is not allowed to make the payment")
                case .storeProductNotAvailable:
                    delegate?.errorAlert("The product is not available in the current storefront")
                    print("The product is not available in the current storefront")
                case .cloudServicePermissionDenied:
                    delegate?.errorAlert("Access to cloud service information is not allowed")
                    print("Access to cloud service information is not allowed")
                case .cloudServiceNetworkConnectionFailed:
                    delegate?.errorAlert("Could not connect to the network")
                    print("Could not connect to the network")
                case .cloudServiceRevoked:
                    delegate?.errorAlert("User has revoked permission to use this cloud service")
                    print("User has revoked permission to use this cloud service")
                default:
                    delegate?.errorAlert((error as NSError).localizedDescription )
                    print((error as NSError).localizedDescription)
                }
            }
        }
    }
}


// MARK: - How to use
/*
 var IAPType : IAPHelper.IAPSubscriptionTypes = .subsciptionYearly

 // MARK:  View LifeCycle
 override func viewDidLoad() {
     super.viewDidLoad()
     IAPHelper.shared?.delegate = self
 }
 
 @IBAction func btnContinue(_ sender: Any) {
     SVProgressHUD.show()
     IAPHelper.shared?.purchase(productID: self.IAPType)
 }
 */
