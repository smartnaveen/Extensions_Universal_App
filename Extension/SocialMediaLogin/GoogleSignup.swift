//
//  GoogleSingup.swift
//  Extension
//
//  Created by Naveen Kumar on 20/12/22.
//

import Foundation
import UIKit
import GoogleSignIn
import FirebaseCore


/*
class LoginScreenVC: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
    }
    
    @IBAction func btnGoogle_Action(_ sender: Any) {
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance()?.signIn()
    }
}
*/
 
/*
// MARK:  Google Signin
extension LoginScreenVC: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue{
                print("The User has not signed in before or they have since signed out.")
                Utility.shared.displayAlert(title: Constants.AppMessages.kError, message: Constants.AppMessages.somethingWentWrong, control: "Ok")
            }else {
                print("\(error.localizedDescription)")
//                Utility.shared.displayAlert(title: "", message: "You have canceled the sign-in flow.", control: "Ok")
            }
            return
        }
        // Perform any operations on signed in user here.
        let socialId = user.userID ?? ""
        let fullName = user.profile.name ?? ""
        let email = user.profile.email ?? ""
        
        print("id -> \(socialId) fullName -> \(fullName) email -> \(email)")
        // Hit api
        self.authVm.signInWithServer(username: email, password: "", isSocial: true, socialId: socialId, socialType: "Google", fullName: fullName) { (msg, stylesCount) in
            if stylesCount == 0{
                let vc = StylesVC().getControllerInstance(identifier: .main)
                vc.isSocialMediaLogin = true
                UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
            }else {
                self.pushToHomeScreen()
            }
        } fail: { (errMsg) in
            Utility.shared.displayAlert(title: Constants.AppMessages.kError, message: errMsg, control: "Ok")
        }
    }
}
*/

// MARK: - AppDelegate & SceneDelegate setup
/*
 import FirebaseCore
 import GoogleSignIn
 
 func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
     FirebaseApp.configure()
     
     GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
     GIDSignIn.sharedInstance().delegate = self
     return true
 }
 
 
 extension AppDelegate: GIDSignInDelegate {
     
     func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
         return GIDSignIn.sharedInstance().handle(url)
     }
     
     func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!){
         if let error = error {
             if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                 print("The user has not signed in before or they have since signed out.")
             } else {
                 print("\(error.localizedDescription)")
             }
             return
         }
         // Perform any operations on signed in user here.
         let userId = user.userID                  // For client-side use only!
         let idToken = user.authentication.idToken // Safe to send to the server
         let fullName = user.profile.name
         let givenName = user.profile.givenName
         let familyName = user.profile.familyName
         let email = user.profile.email
         // ...
     }
 }
 
 // SceneDelegate Setup
   Just Declared function below function......
 func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
     guard let url = URLContexts.first?.url else {
         return
     }
     
//        if UserDefaults.standard.value(forKey: "SAVEUSERID") as? String ?? "" != "" {
//            self.loadHomeview()
//        } else {
//            self.loadLoginView()
//        }
 }
*/

