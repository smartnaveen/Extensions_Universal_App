//
//  CustomTabBar.swift
//  Extension
//
//  Created by Naveen Kumar on 21/11/23.
//

import Foundation
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var navigation: UINavigationController?
    var tabBarController : UITabBarController? = UITabBarController()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        setupCustomTabbar()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
}

// MARK:- SetUP Tabbar
extension SceneDelegate: UITabBarControllerDelegate, UITabBarDelegate{
    func setupCustomTabbar(_ selectdIndex: Int = 0) {
       
        //Notificaitons
        guard let nVC = self.instantiateVC(with: "NotificationVC") as? NotificationVC else {return}
        nVC.tabBarItem.image = UIImage.init(named: "Notification_un")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        nVC.tabBarItem.selectedImage = UIImage.init(named: "Home Black")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        nVC.tabBarItem.imageInsets =  UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        nVC.tabBarItem.title = "Notifications"
        nVC.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.init(named: "AppGreenColor") ?? .green], for: .normal)

        //Appointment
        guard let aVC = self.instantiateVC(with: "AppointmentVC") as? AppointmentVC else {return}
        aVC.tabBarItem.image = UIImage.init(named: "Appointment_un")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        aVC.tabBarItem.selectedImage = UIImage.init(named: "appointment")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        aVC.tabBarItem.imageInsets =  UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        aVC.tabBarItem.title = "Appointments"
        aVC.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.init(named: "AppGreenColor") ?? .green], for: .normal)

        //Services
        guard let hVC = self.instantiateVC(with: "HomeVC") as? HomeVC else {return}
        hVC.tabBarItem.image = UIImage.init(named: "Services_un")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        hVC.tabBarItem.selectedImage = UIImage.init(named: "Services")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        hVC.tabBarItem.imageInsets =  UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
//        hVC.tabBarItem.title = "Services"
        hVC.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.init(named: "AppGreenColor") ?? .green], for: .normal)

        //Medical Profile
        guard let mVC = self.instantiateVC(with: "MedicalProfileVC") as? MedicalProfileVC else {return}
        mVC.tabBarItem.image = UIImage.init(named: "Medical_un")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        mVC.tabBarItem.selectedImage = UIImage.init(named: "Medical")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        mVC.tabBarItem.imageInsets =  UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        mVC.tabBarItem.title = "Medical Profile"
        mVC.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.init(named: "AppGreenColor") ?? .green], for: .normal)

        // Settings
        guard let sVC = self.instantiateVC(with: "SettingsVC") as? SettingsVC else {return}
        sVC.tabBarItem.image = UIImage.init(named: "Settings_un")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        sVC.tabBarItem.selectedImage = UIImage.init(named: "Settings")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        sVC.tabBarItem.imageInsets =  UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        sVC.tabBarItem.title = "Settings"
        sVC.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.init(named: "AppGreenColor") ?? .green], for: .normal)

        let nNavigation : UINavigationController = UINavigationController(rootViewController: nVC)
        let aNavigation : UINavigationController = UINavigationController(rootViewController: aVC)
        let hNavigation : UINavigationController = UINavigationController(rootViewController: hVC)
        let mNavigation : UINavigationController = UINavigationController(rootViewController: mVC)
        let sNavigation : UINavigationController = UINavigationController(rootViewController: sVC)

        nNavigation.navigationBar.isHidden = true
        aNavigation.navigationBar.isHidden = true
        hNavigation.navigationBar.isHidden = true
        mNavigation.navigationBar.isHidden = true
        sNavigation.navigationBar.isHidden = true

        self.tabBarController?.viewControllers = [nNavigation , aNavigation, hNavigation, mNavigation, sNavigation]
    
        self.tabBarController?.tabBar.backgroundColor = UIColor.white
        self.tabBarController?.tabBar.layer.cornerRadius = 22
        self.tabBarController?.selectedIndex = selectdIndex
        self.tabBarController?.tabBar.barTintColor = .red
        self.tabBarController?.delegate = self
        
        if #available(iOS 13.0, *) {
            UIApplication.shared.windows.first?.rootViewController = self.tabBarController!
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        } else {
            self.window?.rootViewController = self.tabBarController!
            self.window?.makeKeyAndVisible()
        }
    }
    
//    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController){
//        let currentIndex = tabBarController.selectedIndex
//        let tabbarTitle = ["Notifications", "Appointments", "Services", "Medical Profile", "Settings"]
//        if let tab = tabBarController.tabBar.items  {
//            for (index, element) in tab.enumerated() {
//                if index == currentIndex{
//                    element.title = ""
//                    element.imageInsets = UIEdgeInsets.init(top: -22, left: 0, bottom: 0, right: 0)
//
//                    let view = element.value(forKey: "view") as? UIView
//                    UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveLinear, animations: {
//                        view?.transform = CGAffineTransformRotate(view!.transform, CGFloat.pi)
//                    }, completion: {
//                       (value: Bool) in
//                        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveLinear, animations: {
//                                 view?.transform = CGAffineTransformIdentity
//                            }, completion: nil)
//                    })
//                }else{
//                    element.title = tabbarTitle[index]
//                    element.imageInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
//                }
//            }
//        }
//    }
}

extension NSObject{
    func instantiateVC(with identifier: String) -> UIViewController {
        let MainStoryBoard = UIStoryboard(name: "Main", bundle: .main)
        return MainStoryBoard.instantiateViewController(withIdentifier: identifier)
    }
}
