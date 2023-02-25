//
//  GADRewarded.swift
//  Extension
//
//  Created by Naveen Kumar on 25/02/23.
//

import Foundation
import UIKit
import GoogleMobileAds

protocol GADRewardedDelegate: AnyObject {
    func adsRewardedDidSucceed()
    func adsRewardedDidDismiss()
    func errorAlert(_ errMsg: String)
}

class GADRewarded: NSObject {
    static var shared = GADRewarded()
    
    private var rewardedAd: GADRewardedAd?
    weak var delegate: GADRewardedDelegate?
    
    func loadAds() {
        GADRewardedAd.load(withAdUnitID: "ca-app-pub-3940256099942544/1712485313", request: GADRequest()) { (ad, error) in
            if let error = error {
                print("Rewarded ad failed to load with error: \(error.localizedDescription)")
                self.delegate?.errorAlert("\(error.localizedDescription).")
                return
            }
            print("Loading Succeeded")
            self.rewardedAd = ad
            self.rewardedAd?.fullScreenContentDelegate = self
        }
    }
    
    func showAds(fromController: UIViewController) {
        loadAds()
        if let ad = rewardedAd { ad.present(fromRootViewController: fromController) {
            let reward = ad.adReward
            print("Reward received with currency \(reward.amount), amount \(reward.amount.doubleValue)")
            self.delegate?.adsRewardedDidSucceed()
        }
        } else {
            delegate?.errorAlert("The rewarded ad cannot be shown at this time.")
        }
    }
}

extension GADRewarded: GADFullScreenContentDelegate{
    func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Rewarded ad will be presented.")
    }
    
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Rewarded ad dismissed.")
        self.delegate?.adsRewardedDidDismiss()
    }
    
    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        delegate?.errorAlert("Rewarded ad failed to present with error: \(error.localizedDescription).")
        print("Rewarded ad failed to present with error: \(error.localizedDescription).")
    }
}

// MARK: - How to use
/*
 // MARK:  View LifeCycle
 override func viewDidLoad() {
     super.viewDidLoad()
 GADRewarded.shared.loadAds()
 GADRewarded.shared.delegate = self
 }
 
 @IBAction func btnContinue(_ sender: Any) {
 GADRewarded.shared.showAds(fromController: self)
 }

 */

/*
 extension ThemeVC: GADRewardedDelegate{
     func adsRewardedDidSucceed() {
         print("Rewarded granted")
     }
     
     func adsRewardedDidDismiss() {
         print("Rewared screen did dismiss")
     }
     
     func errorAlert(_ errMsg: String) {
         UtilityMangr.shared.showAlert(title: GConstant.kError, msg: errMsg, vwController: self)
     }
 }
 */
