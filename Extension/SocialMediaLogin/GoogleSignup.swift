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

class LoginScreenVC: UIViewController, GIDSignInDelegate  {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
    }
    
    @IBAction func btnGoogle_Action(_ sender: Any) {
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                print("The user has not signed in before or they have since signed out.")
            } else {
                print("\(error.localizedDescription)")
            }
            return
        }
        
        // Perform any operations on signed in user here.
        /*
         userIdG = user.userID                  // For client-side use only!
         idTokenG = user.authentication.idToken // Safe to send to the server
         fullNameG = user.profile.name
         givenNameG = user.profile.givenName
         familyNameG = user.profile.familyName
         emailG = user.profile.email
         print("user email is==>" , user.profile.email)
         DispatchQueue.main.async {
         self.socialLoginApi(type: "G")
         
         }
         */
    }
}


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
     
     func application(_ app: UIApplication,
                      open url: URL,
                      options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
         
         return GIDSignIn.sharedInstance().handle(url)
     }
     
     func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
               withError error: Error!) {
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

