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
 @IBAction func btnFacebook(_ sender: Any) {
     let fbLoginManager : LoginManager = LoginManager()
     fbLoginManager.logIn(permissions: ["public_profile", "email"], from: self) { (result, error) -> Void in
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
         let requestMe = GraphRequest.init(graphPath: "me", parameters: ["fields" : "id,name,email,picture.type(large)"])
         let connection = GraphRequestConnection()
         connection.add(requestMe, completionHandler:{ (connectn, userresult, error) in
             if error != nil {
                 Utility.shared.displayAlert(title: Constants.AppMessages.kError, message: error.debugDescription, control: "Ok")
                 NSLog(error.debugDescription)
                 return
             }

             if let dictData: [String : Any] = userresult as? [String : Any] {
                 let email = dictData["email"] as? String ?? ""
                 let fullName = dictData["name"] as? String ?? ""
                 let fbId = dictData["id"] as? String ?? ""
               
                 // Hit api
                 DispatchQueue.main.async {
                     self.authVm.signInWithServer(username: email, password: "", isSocial: true, socialId: fbId, socialType: "Facebook", fullName: fullName) { (msg, stylesCount) in
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
         })
         connection.start()
     }
     else {
         Utility.shared.displayAlert(title: Constants.AppMessages.kError, message: Constants.AppMessages.somethingWentWrong, control: "Ok")
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
