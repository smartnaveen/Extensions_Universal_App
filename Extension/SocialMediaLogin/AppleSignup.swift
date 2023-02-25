//
//  AppleSignup.swift
//  Extension
//
//  Created by Naveen Kumar on 25/02/23.
//

import Foundation
import UIKit
import AuthenticationServices

/*
 @IBAction func btnApple(_ sender: Any) {
     Indicator.shared().start()
     let request = ASAuthorizationAppleIDProvider().createRequest()
     request.requestedScopes = [.fullName, .email]
     let controller = ASAuthorizationController(authorizationRequests: [request])
     controller.delegate = self
     controller.presentationContextProvider = self
     controller.performRequests()
 }
 */

/*
 // MARK:  Apple Login
 extension LoginVC: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
     
     func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
         Indicator.shared().start()
         switch authorization.credential {
         case let appleIDCredential as ASAuthorizationAppleIDCredential:
             let userIdentifier = appleIDCredential.user
             let gName = appleIDCredential.fullName?.givenName ?? ""
             let mName = appleIDCredential.fullName?.middleName ?? ""
             let fName = appleIDCredential.fullName?.familyName ?? ""
             let email = appleIDCredential.email ?? ""
             
             let fullName = "\(gName) \(mName) \(fName)"
             print(fullName, email)
             
             // Hit api
             self.authVm.signInWithServer(username: email, password: "", isSocial: true, socialId: userIdentifier, socialType: "Apple", fullName: fullName) { (msg, stylesCount) in
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
             break
         default:
             break
         }
     }
     
     func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
         return self.view.window!
     }
     
     func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
         Indicator.shared().stop()
         Utility.shared.displayAlert(title: Constants.AppMessages.kError, message: error.localizedDescription, control: "Ok")
     }
 }

 */
