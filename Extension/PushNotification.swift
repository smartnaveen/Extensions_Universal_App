//
//  PushNotification.swift
//  Firestore Demo
//
//  Created by Naveen Kumar on 21/10/21.
//

import Foundation
import UIKit

class PushNotification: NSObject {
    static let shared = PushNotification()
    
    let osType = "1"
    let firebaseServer_Key = "key=AAAA2X56D7U:APA91bG0cNdquUEVdS43zKmsrtHdzSqSRsYVVdvjCyY2B_xWa7EzOkGcVD5daVKGW6LAq2mHZvYke8A0kGoB7Mb2_DQ_6_UNVXpfDQCh4hxWnIWCjrD4LzAgeM_5oEEIRs9KVbMgTySY"
    
    let fcmToken = "fu8sJeZ3UEiFkxEHncPeAv:APA91bG3XgG6HV5QlWhjE1PJAcqf1RBP240Lp8CU9V4Gumf1eW6bxh9OtWOFit9lHPARCnA4XI1H9cwSx6wezl84iWRGPryayKLKnZ9y0aReoiCZ-mMSeDYCN12XhtK2fOIGP5TICsay"

    
    // MARK: - Trigger Notifcation when Click on button
    /*
     @IBAction func triggerNofication(_ sender: UIButton) {
         sendPushNotification(to: fcmToken, title: "Congratulations 🥰", subTitle: "Book rooms at FLAT 50% off now", body: "Don't miss out ⏱", data: ["HI": "88980"])
     }
     */
    
    
    //MARK:- Send push notification API
    func sendPushNotification(to token: String = "\(PushNotification.shared.fcmToken)", title: String, subTitle: String, body: String, data:[String:Any]) {
        let urlString = "https://fcm.googleapis.com/fcm/send"
        let url = NSURL(string: urlString)!
        var parameter = [String : Any]()
        
        if osType == "1"{
            //os_type type 1 is for iOS
            
            parameter = ["registration_ids" : ["\(token)"],
                         "notification" : ["data": data, "title" : title, "subtitle": subTitle , "body": body,          "sound": "default"],
                         "data" : data
            ]
        }else{
            //os_type type 0 is for android
            parameter = ["registration_ids" : ["\(token)"],
                         "data" : data
            ]
        }
        
        print(parameter)
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject:parameter, options: [.prettyPrinted])
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("\(firebaseServer_Key)", forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            do {
                if let jsonData = data {
                    if let jsonDataDict = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: AnyObject] {
                        NSLog("Received data:\n\(jsonDataDict))")
                        
                        DispatchQueue.main.async {
                            UIApplication.shared.registerForRemoteNotifications()
                        }
                    }
                }
            } catch let err as NSError {
                print(err.debugDescription)
            }
        }
        task.resume()
    }
}



// MARK: - App Delegate Implementation
import FirebaseMessaging
import MessageUI


/*
 class AppDelegate: UIResponder, UIApplicationDelegate, MessagingDelegate, UNUserNotificationCenterDelegate {

     var window: UIWindow?
     
     func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
         FirebaseApp.configure()
         
         Messaging.messaging().delegate = self
         Messaging.messaging().isAutoInitEnabled = true

         
         if #available(iOS 10.0, *) {
           // For iOS 10 display notification (sent via APNS)
           UNUserNotificationCenter.current().delegate = self

           let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
           UNUserNotificationCenter.current().requestAuthorization(
             options: authOptions) { isGranted, error in
                 if !isGranted{
                     print("something wrong in permission")
                 }else {
                     DispatchQueue.main.async {
                         application.registerForRemoteNotifications()
                         UIApplication.shared.registerForRemoteNotifications()

                         Messaging.messaging().token { token, error in
                           if let error = error {
                             print("Error fetching FCM registration token: \(error)")
                           } else if let token = token {
                             print("FCM registration token: \(token)")
                               
                           }
                         }
                     }
                 }
             }
         } else {
           let settings: UIUserNotificationSettings =
             UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
           application.registerUserNotificationSettings(settings)
         }
         
         return true
     }


 }
 */

extension AppDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
      print("Firebase registration token: \(String(describing: fcmToken ?? ""))")

      let dataDict: [String: String] = ["token": fcmToken ?? ""]
      NotificationCenter.default.post(
        name: Notification.Name("FCMToken"),
        object: nil,
        userInfo: dataDict
      )
      // TODO: If necessary send token to application server.
      // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
}


@available(iOS 10, *)
extension AppDelegate {
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
    
  // Receive displayed notifications for iOS 10 devices.
  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              willPresent notification: UNNotification,
                              withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions)
                                -> Void) {
    let userInfo = notification.request.content.userInfo
    // With swizzling disabled you must let Messaging know about the message, for Analytics
     Messaging.messaging().appDidReceiveMessage(userInfo)

    // ...

    // Print full message.
    print(userInfo)

    // Change this to your preferred presentation option
      completionHandler([.alert, .sound])
  }

  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              didReceive response: UNNotificationResponse,
                              withCompletionHandler completionHandler: @escaping () -> Void) {
    let userInfo = response.notification.request.content.userInfo

      print("Notification Data = \(userInfo)")
      
      if  let noti_type = userInfo["gcm.notification.type"] as? String{
//          if noti_type == "1"{
//              let vc = storyBoard.instantiateViewController(withIdentifier: "HomePageNav") as! UINavigationController
//              let senderId = userInfo["gcm.notification.senderId"] as? String ?? ""
//              DEFAULT.set("YES", forKey: "FROMNOTI")
//              DEFAULT.set(senderId, forKey: "senderId")
//              DEFAULT.synchronize()
//              self.window?.rootViewController = vc
//              self.window?.makeKeyAndVisible()
//          }
      }


      completionHandler()
  }
    
    
    func application(_ application: UIApplication,
    didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
      Messaging.messaging().apnsToken = deviceToken;
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        completionHandler(UIBackgroundFetchResult.newData)
    }
}
