//
//  AppDelegate.swift
//  Stylist
//
//  Created by SFS on 06/10/20.
//  Copyright © 2020 SFS. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import GooglePlaces
import GoogleMaps
import Firebase
import FirebaseCrashlytics
import FirebaseMessaging


typealias Completion = () -> Void

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var navigation: UINavigationController?
    
    var tabBarController : UITabBarController? = UITabBarController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //Place
        GMSPlacesClient.provideAPIKey(GConstant.GooglePlaceKey)
        GMSServices.provideAPIKey(GConstant.GooglePlaceKey)
        //Delay in splash screen
        Thread.sleep(forTimeInterval: 1.5)
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        //MARK:Firebase Analytics
        FirebaseApp.configure()
        
        registerForNotification()
        Messaging.messaging().delegate = self
        application.registerForRemoteNotifications()
        
        //Keyboard
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        

        if AppManager.isLogin(){
            AppManager.getLoggedInUser()
            AppDelegate.shared.setupCustomTabbar()
        } else if AppManager.isShowOnBoard() {
            self.gotoOnBoardscreen()
        } else {
            self.moveToLandingPage()
        }
        
//        <<<<<<< HEAD
//                    AppDelegate.shared.setupCustomTabbar()
//                } else if AppManager.isShowOnBoard() {
//                    AppDelegate.shared.gotoOnBoardscreen()
//                } else {
//        =======
        
        //Set up for push notificatios
        self.setDeviceForPushNotification(application)
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        if AppManager.isLogin(){
            //            LocationManager.shared.checkAuthorizationStatus()
        }
    }
    
    //MARK: Custom Methods
    class var shared:AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    //MARK: Move to landing page
    func moveToLandingPage(){
        let objController = self.instantiateVC(withStartupSB: AppManager.isSkipIntro() ? "LoginVC" : "LandingVC")
        AppDelegate.shared.navigation = UINavigationController.init(rootViewController: AppManager.isSkipIntro() ? (objController as! LoginVC) : (objController as! LandingVC))
        if #available(iOS 13.0, *) {
            UIApplication.shared.windows.first?.rootViewController = AppDelegate.shared.navigation
        }else{
            self.window?.rootViewController = AppDelegate.shared.navigation
        }
    }
    
    func gotoOnBoardscreen() {
        let objController = self.instantiateVC(withStartupSB: "OnboardlistVC") as! OnboardlistVC
        AppDelegate.shared.navigation = UINavigationController.init(rootViewController: objController)
        if #available(iOS 13.0, *) {
            UIApplication.shared.windows.first?.rootViewController = AppDelegate.shared.navigation
        }else{
            self.window?.rootViewController = AppDelegate.shared.navigation
        }
    }
    
    //MARK: Move to Payment page
    func movePaymentPage(){
//        self.setupCustomTabbar()
        let objController = self.instantiateVC(withStartupSB: "LinkAddAccountVC") as! LinkAddAccountVC
        AppDelegate.shared.navigation = UINavigationController.init(rootViewController: objController)
        if #available(iOS 13.0, *) {
            UIApplication.shared.windows.first?.rootViewController = AppDelegate.shared.navigation
        }else{
            self.window?.rootViewController = AppDelegate.shared.navigation
        }
    }
}

extension AppDelegate: UITabBarControllerDelegate, UITabBarDelegate{
    //MARK: Set up TabBar
    
    func setupCustomTabbar() {
        
        //Home
        guard let homeVC = self.instantiateVC(withMainSB: "HomeVC") as? HomeVC else {return}
        homeVC.tabBarItem.image = UIImage.init(named: "home")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        homeVC.tabBarItem.selectedImage = UIImage.init(named: "home_selected")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        homeVC.tabBarItem.imageInsets =  UIEdgeInsets.init(top: 10, left: 0, bottom: -10, right: 0)
        
        //Wallet
        guard let walletVC = self.instantiateVC(withMainSB: "EarningVC") as? EarningVC else {return}
        walletVC.tabBarItem.image = UIImage.init(named: "search")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        walletVC.tabBarItem.selectedImage = UIImage.init(named: "search_active")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        walletVC.tabBarItem.imageInsets =  UIEdgeInsets.init(top: 10, left: 0, bottom: -10, right: 0)
        
        //Booking
        guard let listVC = self.instantiateVC(withMainSB: "BookingVC") as? BookingVC else {return}
        listVC.tabBarItem.image = UIImage.init(named: "order")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        listVC.tabBarItem.selectedImage = UIImage.init(named: "order_active")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        listVC.tabBarItem.imageInsets =  UIEdgeInsets.init(top: 10, left: 0, bottom: -10, right: 0)
        
        //Profile
        guard let userVC = self.instantiateVC(withMainSB: "ProfileVC") as? ProfileVC else {return}
        userVC.tabBarItem.image = UIImage.init(named: "profile")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        userVC.tabBarItem.selectedImage = UIImage.init(named: "profile_active")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        userVC.tabBarItem.imageInsets =  UIEdgeInsets.init(top: 10, left: 0, bottom: -10, right: 0)
        
        
        //Set Navigation
        let homeNavigation : UINavigationController = UINavigationController(rootViewController: homeVC)
        let walletNavigation : UINavigationController = UINavigationController(rootViewController: walletVC)
        let listNavigation : UINavigationController = UINavigationController(rootViewController: listVC)
        let userNavigation : UINavigationController = UINavigationController(rootViewController: userVC)
        
        //Hidden Navigation Bar
        homeNavigation.navigationBar.isHidden   = true
        walletNavigation.navigationBar.isHidden = true
        listNavigation.navigationBar.isHidden   = true
        userNavigation.navigationBar.isHidden   = true
        
        //Set TabBarViewController
        self.tabBarController?.viewControllers = [homeNavigation , walletNavigation, listNavigation, userNavigation]
        
        self.tabBarController?.tabBar.backgroundColor = UIColor.white
        
        let layer   = CAShapeLayer()
        let rect    = CGRect(x: 0, y: (self.tabBarController?.tabBar.bounds.minY)!, width: (self.tabBarController?.tabBar.bounds.width)!, height: (self.tabBarController?.tabBar.bounds.height)!)
        layer.path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topRight, .topLeft], cornerRadii: CGSize(width: 20, height:  20)).cgPath
        layer.shadowColor   = UIColor.AppGrayColor.cgColor
        layer.shadowOffset  = CGSize(width: 0, height: 0)
        layer.shadowRadius  = 8
        layer.shadowOpacity = 0.4
        layer.borderWidth   = 0
        layer.opacity       = 0.2
        layer.isHidden      = false
        layer.masksToBounds = false
        layer.fillColor     = UIColor.white.cgColor
        
        self.tabBarController?.tabBar.shadowImage       = UIImage()
        self.tabBarController?.tabBar.backgroundImage   = UIImage()
        self.tabBarController?.tabBar.layer.insertSublayer(layer, at: 0)
        self.tabBarController?.delegate = self
        
        if #available(iOS 13.0, *) {
            UIApplication.shared.windows.first?.rootViewController = self.tabBarController!
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        } else {
            self.window?.rootViewController = self.tabBarController!
            self.window?.makeKeyAndVisible()
        }
    }
}

//Notification
extension AppDelegate : UNUserNotificationCenterDelegate,MessagingDelegate{
    
    //MARK: Device Token
    func setDeviceForPushNotification(_ application : UIApplication){
        // For iOS 10 display notification (sent via APNS)
        UNUserNotificationCenter.current().delegate = self
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: {_, _ in })
        application.registerForRemoteNotifications()
    }
    
    func application( _ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data ) {
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        
        print("Device_token %@",deviceTokenString)
        
        //     UserDefaults.SFSDefault(setObject: deviceTokenString, forKey: GConstant.kDeviceToken)
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        guard fcmToken != nil else { return print("The device token not found") }
        print("The device token \(fcmToken!)")
        //Save the token to local storage and post to app server to generate Push Notification...
        UserDefaults.SFSDefault(setValue: fcmToken!, forKey: GConstant.kDeviceToken)
    }
    
    func registerForNotification() {
        UNUserNotificationCenter.current().requestAuthorization(options:[.badge, .alert, .sound]) { (granted, error) in
            if granted {
                DispatchQueue.main.async {
                    UNUserNotificationCenter.current().delegate = self
                    UIApplication.shared.registerForRemoteNotifications()
                    let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
                    UNUserNotificationCenter.current().requestAuthorization(
                        options: authOptions,
                        completionHandler: {_, _ in })
                }
            }
        }
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        if let userInfo = response.notification.request.content.userInfo as? Dictionary<String, Any> {
            //Add notification center
            
            AppManager.getLoggedInUser()
            let type = userInfo["notification_type"] as? String
            if type == "account_accepted"{
                GConstant.loggedInUser.registration_status = "accepted"
            }else if type == "account_waiting"{
                GConstant.loggedInUser.registration_status = "awaiting"
            }else{
                GConstant.loggedInUser.registration_status = "rejected"
            }
            AppManager.saveSignUpUser(currentUser: GConstant.loggedInUser)
            
            self.didReceiveNotificationResponse(userInfo: userInfo)
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UpdateUserStatusOnTab"), object: nil , userInfo: userInfo)
            print(userInfo)
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        if let userInfo = notification.request.content.userInfo as? Dictionary<String, Any> {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UpdateUserStatus"), object: nil , userInfo: userInfo)
        }
        completionHandler([.alert, .badge, .sound])
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error)
        UserDefaults.SFSDefault(setObject: "", forKey: GConstant.kDeviceToken)
    }
    
    func didReceiveNotificationResponse(userInfo : Dictionary<String, Any>){
        if AppManager.isLogin(){
            if let navigationController = UIApplication.shared.windows.first?.rootViewController as? UINavigationController {
                AppManager.getLoggedInUser()
                let type = userInfo["notification_type"] as? String
                if type == "account_accepted"{
                    GConstant.loggedInUser.registration_status = "accepted"
                    let vc = self.instantiateVC(withStartupSB: "ApproveVC") as! ApproveVC
                    navigationController.animationDuringPush(vc)
                }else if type == "account_waiting"{
                    GConstant.loggedInUser.registration_status = "awaiting"
                    let vc = self.instantiateVC(withStartupSB: "PendingApprovalVC") as! PendingApprovalVC
                    navigationController.animationDuringPush(vc)
                }else{
                    GConstant.loggedInUser.registration_status = "rejected"
                    let vc = self.instantiateVC(withStartupSB: "RejectedVC") as! RejectedVC
                    navigationController.animationDuringPush(vc)
                }
                AppManager.saveSignUpUser(currentUser: GConstant.loggedInUser)
            }
        }
    }
}

//MARK: Mana
extension UITabBar {
    
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        var tabHeight = CGFloat()
        
        switch UIDevice.current.screenType {
        case .iPhones_5_5s_5c_SE:
            tabHeight = 50
            break
        case .iPhones_6_6s_7_8:
            tabHeight = 65
            break
        case .iPhones_6Plus_6sPlus_7Plus_8Plus:
            tabHeight = 75
            break
        default:
            tabHeight = 100
            break
        }
        sizeThatFits.height = tabHeight
        return sizeThatFits
    }
}

