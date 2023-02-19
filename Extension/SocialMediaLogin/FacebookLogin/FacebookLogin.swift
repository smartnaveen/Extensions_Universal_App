//
//  FacebookLogin.swift
//  Extension
//
//  Created by Naveen Kumar on 19/02/23.
//

/*
 import Foundation
 import FBSDKLoginKit
 import UIKit
 */

/*
pod 'FBSDKCoreKit'
pod 'FBSDKLoginKit'
*/

/*
 // MARK: - Facebook Login Button
 @IBAction func btnFbAct(_ sender: UIButton){
     self.login_Type = "F"
     let fbLoginManager : LoginManager = LoginManager()
     fbLoginManager.logIn(permissions: ["email"], from: self) { (result, error) -> Void in
         if (error == nil){
             let fbloginresult : LoginManagerLoginResult = result!
             // if user cancel the login
             if (result?.isCancelled)!{
                 return
             }
             if(fbloginresult.grantedPermissions.contains("email")){
                 print("login done now getting user detail")
                 self.getFBUserData()
             }
         } else {
             print("getting error while login")
         }
     }
 }
 
 func getFBUserData(){
     if((AccessToken.current) != nil){
         GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
             if (error == nil){
                 //everything works print the user data
                 print("result==>" , result)
                 
                 self.login_Type = "F"
                 self.email = ((result as AnyObject).value(forKey: "email") ?? "") as! String
                 self.SUserId = ((result as AnyObject).value(forKey: "id") ?? "") as! String
                 
                 
                 let firstName = ((result as AnyObject).value(forKey: "first_name") ?? "") as! String
                 let lastName = ((result as AnyObject).value(forKey: "last_name") ?? "") as! String
                 
                 self.fullName = firstName + " " + lastName
                 DispatchQueue.main.async {
                     self.socialLoginApi()
                 }
             }
         })
     } else {
         print("access error")
     }
 }
 */

// MARK: - AppDelegate setup
/*
import FBSDKCoreKit

 func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
     FirebaseApp.configure()
     
     GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
     GIDSignIn.sharedInstance().delegate = self
 
     ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)

     return true
 }
 
 func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
     ApplicationDelegate.shared.application( app, open: url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplication.OpenURLOptionsKey.annotation])
     return GIDSignIn.sharedInstance().handle(url)
 }
 
 */

// MARK: - SceneDelegate setup
/*
import FBSDKCoreKit

 Just Declared function below function......
func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
   guard let url = URLContexts.first?.url else {
       return
   }
 
 ApplicationDelegate.shared.application(UIApplication.shared, open: url, sourceApplication: nil, annotation: [UIApplication.OpenURLOptionsKey.annotation])

        if UserDefaults.standard.value(forKey: "SAVEUSERID") as? String ?? "" != "" {
            self.loadHomeview()
        } else {
            self.loadLoginView()
        }
}
*/
