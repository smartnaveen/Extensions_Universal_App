//
//  NetworkReachability.swift
//  Extension
//
//  Created by Mr. Naveen Kumar on 23/03/21.
//

import Foundation
import UIKit
import Reachability

class NetworkReachability: NSObject {
    static let shared = NetworkReachability()
    let reachability = try? Reachability()
    var isNetworkAvailable : Bool {
        return reachabilityStatus != .unavailable
    }
    var reachabilityStatus: Reachability.Connection = .unavailable
    @objc func reachabilityChanged(notification: Notification) {
       // reachabilityStatus = notification.object as? Reachability.Connection ?? reachability?.connection as! Reachability.Connection
        reachabilityStatus = reachability!.connection
        switch reachabilityStatus {
        case .none:
            debugPrint("Network became unreachable")
        case .wifi:
            debugPrint("Network reachable through WiFi")
        case .cellular:
            debugPrint("Network reachable through Cellular Data")
        case .unavailable:
            debugPrint("Network unavailable")
        }
        NotificationCenter.default.post(name: NSNotification.Name("NetworkChanged"), object: nil)
    }

    /// Starts monitoring the network availability status
    func startMonitoring() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.reachabilityChanged),
                                               name: Notification.Name.reachabilityChanged,
                                               object: reachability)
        do{
            try reachability!.startNotifier()
        } catch {
            debugPrint("Could not start reachability notifier")
        }
    }
    /// Stops monitoring the network availability status
    func stopMonitoring(){
        reachability!.stopNotifier()
        NotificationCenter.default.removeObserver(self,
                                                  name: Notification.Name.reachabilityChanged,
                                                  object: reachability)
    }
}


 // MARK:- HOW CAN I USED NETWORKREACHABILITY CLASS
/*
 Step1 - NetworkReachability.shared.startMonitoring() -> In didfinishlaunchingwithoption in appdelegate.
 Step2 -   if NetworkReachability.shared.isNetworkAvailable {
                 debugPrint("Internet")
            }else {
                 debugPrint("No Internet")
            }
 */




// MARK: - BY using Alamofire (Most Using)
//import Alamofire
/*
 class func isConnectedToNetwork() -> Bool {
      guard let reachability = Alamofire.NetworkReachabilityManager()?.isReachable else { return false }
      return reachability ? true: false
  }
 */


 
    
    


