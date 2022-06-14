//
//  SSL Invalid Certificate.swift
//  Extension
//
//  Created by Naveen Kumar on 22/12/21.
//

import Foundation
import Alamofire

/*
 <key>NSAppTransportSecurity</key>
 <dict>
     <key>NSAllowsArbitraryLoads</key>
     <true/>
     <key>moritzsternemann.de</key>
     <dict>
         <key>NSIncludesSubdomains</key>
         <true/>
         <key>NSExceptionAllowsInsecureHTTPLoads</key>
         <true/>
         <key>NSThirdPartyExceptionRequiresForwardSecrecy</key>
         <false/>
         <key>NSExceptionRequiresForwardSecrecy</key>
         <false/>
         <key>NSThirdPartyExceptionAllowsInsecureHTTPLoads</key>
         <true/>
         <key>NSTemporaryExceptionAllowsInsecureHTTPLoads</key>
         <true/>
         <key>NSTemporaryExceptionMinimumTLSVersion</key>
         <string>TLSv1.1</string>
         <key>NSThirdPartyExceptionMinimumTLSVersion</key>
         <string>TLSv1.1</string>
         <key>NSRequiresCertificateTransparency</key>
         <false/>
     </dict>
 </dict>

 */


/*
 final class SampleNetworkManager {
     private let session: Session
     
     init() {
         let evaluators: [String: ServerTrustEvaluating] = [
             "order.asianexpress.com.hk": PinnedCertificatesTrustEvaluator(validateHost: true)
         ]
         
         let serverTrustManager = ServerTrustManager(evaluators: evaluators)
         self.session = Session(serverTrustManager: serverTrustManager)
     }
 }
 */

/*
 func registrationAPI() {
     let urlString = "https://order.asianexpress.com.hk/wp-json/custom/v1/register"
     
     var param: [String: Any] = [String: Any]()
     param["user_login"] = self.tfUserName.text ?? ""
     param["user_tel"] = self.tfPhoneNumber.text ?? ""
     param["user_email"] = self.tfEmail.text ?? ""
     param["user_gender"] = self.gender
     param["user_pass"] = self.tfConfirmpassword.text ?? ""
     
     wait?.startAnimating()
     APIManager.Manager.request(urlString, method: .post, parameters: param, encoding: URLEncoding.default , headers: nil).responseJSON { (response: AFDataResponse<Any>) in
         self.wait?.stopAnimating()
         self.wait?.hidesWhenStopped = true
         switch(response.result){
         case .success(let response):
             print("result \n \(response)")
             
             if let safeResponse = response as? [String: Any]{
                 print(safeResponse["message"]!)
             }
             
         case .failure(let error):
             print(error)
             self.alert(message: "\(error)")
         }
     }
     
 }
 */

/*
 class APIManager: NSObject, URLSessionDelegate {
     
     static let shared = APIManager()
     
     static var Manager: Alamofire.Session = {
             let manager = ServerTrustManager(evaluators: ["order.asianexpress.com.hk": DisabledTrustEvaluator()])
             let session = Session(serverTrustManager: manager)
            return session
         }()
 
 }
 */
