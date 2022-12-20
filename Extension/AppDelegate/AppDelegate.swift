//
//  AppDelegate.swift
//  Extension
//
//  Created by Mr. Naveen Kumar on 11/03/21.
//

import UIKit
import Firebase
import GoogleMaps
import GooglePlaces

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()

        GMSServices.provideAPIKey("AIzaSyATVFeWh9TdCsnbWD4qDb7n6l5QNu3hQEo")
        GMSPlacesClient.provideAPIKey("AIzaSyDf4uyT5Tm9JGA6CCq-GBWquA84IbXCQeQ")

        NetworkReachability.shared.startMonitoring()
        for family in UIFont.familyNames {
            for name in UIFont.fontNames(forFamilyName: family) {
//                print("\(name)")
            }
        }
    
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

