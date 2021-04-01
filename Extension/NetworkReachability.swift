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
        reachabilityStatus = notification.object as? Reachability.Connection ?? reachability?.connection as! Reachability.Connection
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







 // MARK:- Not used 
    
//    func handleReachability() {
//        if NetworkReachability.shared.isNetworkAvailable{
//            Global.shared.showLoader()
//            let param = ["user_id": ProfileHandler.shared.id!,"message_type": "text","message": messageTV.text!] as [String : Any]
//             let url = BASE_URL + ADD_USER_FEED
//            APIManager.shared.fetchData(urlString: url, dict: param, requestType: .post, completion: { (result) in
//                debugPrint(result)
//                Global.shared.hideLoader()
//                if result["error"] as? String == "1" {
//                    Global.shared.showAlert("\(result["status"]!)")
//                }else{
//                     //Dismiss View and reload feeds
//                      self.dismiss(animated: false, completion: nil)
//                }
//            }) { (error) in
//                Global.shared.hideLoader()
//                Global.shared.showAlert(error)
//            }
//        }else{
//            //       let param = ["user_id": ProfileHandler.shared.id!,"msg_type": "text/Image","message": "message","method" : "user_feed"] as [String : Any]
//            var imageData = [Data]()
//            for image in imageArr{
//                let imgData: Data = image.jpegData(compressionQuality: 0.5)!
//                imageData.append(imgData)
//            }
//            let url = BASE_URL + ADD_USER_FEED
//           // let param = ["user_id": ProfileHandler.shared.id!,"message_type": "image","caption":messageTV.text!] as [String : Any]
//            Global.shared.showLoader()
//
//            APIManager.shared.requestUploadWith(endUrl: url, imageName: "message", imagesData: imageData, parameters: param, onCompletion: { (result) in
//                Global.shared.hideLoader()
//                debugPrint(result)
//                if result["error"] as? String == "1"{
//                    Global.shared.showAlert("\(result["status"]!)")
//                }else{
//                    //Dismiss View and reload feeds
//                    self.dismiss(animated: false, completion: nil)
//                }
//            }) { (err) in
//                Global.shared.hideLoader()
//                Global.shared.showAlert(err!.localizedDescription)
//            }
//        }
//        }
    
    
    


