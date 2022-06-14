//
//  LocalNotification.swift
//  Firestore Demo
//
//  Created by Naveen Kumar on 25/10/21.
//

import UIKit
import UserNotifications

protocol NotificationProtocol: AnyObject {
    func didRecieveNotification()
}

class LocalNotification: NSObject, UNUserNotificationCenterDelegate{
    
    static let shared = LocalNotification()
    
    var notificationCenter = UNUserNotificationCenter.current()
    weak var delegate: NotificationProtocol?
    
    func awakNotification() {
        notificationCenter.delegate = self
        notificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("Request authorization succeeded!")
            }else {
                debugPrint("Error - \(error?.localizedDescription ?? "")")
            }
        }
    }
    
    
    func callNotificationOnButtonClick() {
        let content = UNMutableNotificationContent()
        content.title = "Hello"
        content.subtitle = "787879"
        content.body = "I m fine"
        content.badge = 0
        content.sound = .default
        content.categoryIdentifier = "notify-test"
        
        //Add attachment for Notification with more content
        //        let imageName = "oppsInternet"
        //        guard let imageURL = Bundle.main.url(forResource: imageName, withExtension: "jpg") else { return }
        //        let attachment = try! UNNotificationAttachment(identifier: imageName, url: imageURL, options: .none)
        //        content.attachments = [attachment]
        //
        //
        //        //Add Action button the Notification
        //        let snoozeAction = UNNotificationAction(identifier: "Snooze", title: "Snooze", options: [])
        //        let deleteAction = UNNotificationAction(identifier: "DeleteAction", title: "Delete", options: [.destructive])
        //        let category = UNNotificationCategory(identifier: "notify-test",
        //                                              actions: [snoozeAction, deleteAction],
        //                                              intentIdentifiers: [],
        //                                              options: [])
        //        notificationCenter.setNotificationCategories([category])
        //
        //        //Add Trigger for notification show
        //        //Use it to define trigger condition
        //        var date = DateComponents()
        //        date.calendar = Calendar.current
        //      //  date.weekday = 5 //5 means Friday
        //      //  date.hour = 14 //Hour of the day
        //      // date.minute = 10 //Minute at which it should be sent
        //        date.second = 3
        //        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        //
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.5, repeats: false)
        let request = UNNotificationRequest(identifier: "SimplifiedIOSNotification", content: content, trigger: trigger)
        notificationCenter.add(request) { (error) in
            if let error = error {
                print("Error \(error.localizedDescription)")
            }
        }
    }

}

 // MARK:- Notification Delegate method
extension LocalNotification {
    //Handle Notification Center Delegate methods
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        if #available(iOS 14.0, *) {
            completionHandler([.banner, .sound , .badge])
        } else {
            // Fallback on earlier versions
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.notification.request.identifier == "SimplifiedIOSNotification" {
            print("Handling notifications with the Local Notification Identifier")
            self.delegate?.didRecieveNotification()
//            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController {
//                self.navigationController?.pushViewController(vc, animated: true)
//            }
            
        }
        completionHandler()
    }
}



// MARK: - How to use Localnotification
/*
 @IBAction func gpsButton(_ sender: UIButton) {
     // LocalNotification
     LocalNotification.shared.awakNotification()
     LocalNotification.shared.delegate = self
     LocalNotification.shared.callNotificationOnButtonClick()
 }
 */
