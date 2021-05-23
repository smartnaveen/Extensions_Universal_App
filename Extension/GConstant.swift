//
//  GConstant.swift
//  watch
//
//  Created by Mr. Naveen Kumar on 23/05/21.
//

import Foundation
import UIKit

struct GPAlert {
    let title: String!
    let message: String!
}

struct GConstant {
    static let kAlertTitle: String                  = "Instacuts"
    static let kIsLogin: String                  = "kIsLogin"
    static let kFirstLanch: String                  = "kFirstLanch"
    static let kIsSetupTabbar: String                  = "kIsSetupTabbar"
    static let kIsUploadeProfile: String                  = "kIsUploadeProfile"
    static let kDeviceToken: String                  = "kDeviceToken"
    static let kAuthToken: String                  = "kAuthToken"
    static let kUserID: String                  = "kUserID"
    static let kCurrentUser: String                  = "kCurrentUser"
    static let kSignUpUser: String                  = "kSignUpUser"
    static let kUniqueNameValidation = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ"
    static let kOnlyNumberValidation = "0123456789"
    static let kUserNamelenght = 12
    static let GooglePlaceKey = "AIzaSyDf4uyT5Tm9JGA6CCq-GBWquA84IbXCQeQ"//"AIzaSyBsg3-UPWprhK-Ntyjxs9Xjorr8apB_OPE"
    
//    static var loggedInUser             = UserModel()
//    static var signUpUser               = UserModel()
//    static var arrAddress               = [AddressModel]()
    
    static var isAskForPermission       = false
    static var isAskForLocation         = true
    
    struct Screen {
        static let width        = UIScreen.main.bounds.size.width
        static let height       = UIScreen.main.bounds.size.width
    }
    
    struct AppColor {
        static let primary          = UIColor.white
        static let secondary        = UIColor.white
        static let text             = UIColor.black
        static let font             = UIColor(named: "AppFont")
        static let buttonFont       = UIColor(named: "AppButtonFont")
        static let lightSkyBlue     = UIColor(named: "AppLightSkyBlue")
        static let darkSkyBlue      = UIColor(named: "AppDarkSkyBlue")
        static let darkGray         = UIColor(named: "AppGray")
        static let green            = UIColor(named: "AppGreen")
        static let borderColor      = UIColor(named: "AppBorderColor")
    }
    
    struct LocalUserDefaults {
        static let kAppLaunch                      : String = "kAppLaunch"
        static let kDeviceToken                    : String = "kDeviceToken"
        static let kDeviceTokenVoip                : String = "kDeviceTokenVoip"
        static let kUserData                       : String = "kLoginUserData"
        static let kStreamTrackData                : String = "kStreamTrackData"
        static let kStreamerTutorial               : String = "kStreamerTutorial"
        static let kViewerTutorial                 : String = "kViewerTutorial"
        static let kViewerVideoTutorial            : String = "kViewerVideoTutorial"
        static let kStreamerVideoTutorial          : String = "kStreamerVideoTutorial"
        static let kRequestStreamData              : String = "kRequestStreamData"
        static let kSelectedLanguage               : String = "kSelectedLanguage"
        static let kStreamID              : String = "kStreamRequestID"
    }
    
    struct Alert {
        static func photoPermission() -> GPAlert {
             let kPermissionMessage = "We need to have access to your photos to select a Photo.\nPlease go to the App Settings and allow Photos."
            return GPAlert(title: "Change your Settings", message: kPermissionMessage)
        }
        
        static func contactPermission() -> GPAlert {
            let kPermissionMessage = "This feature requires access to Contacts to proceed. Would you like to open settings and grant permission to contacts?"
            return GPAlert(title: "Change your Settings", message: kPermissionMessage)
        }
        
        static func cameraPermission() -> GPAlert {
            let kPermissionMessage = "We need to have access to your camera to take a New Photo.\nPlease go to the App Settings and allow Camera."
            return GPAlert(title: "Change your Settings", message: kPermissionMessage)
        }
        
        static func locationPermission() -> GPAlert {
            let kPermissionMessage = "We need to have access to your Current Location.\nPlease go to the App Settings and allow Location."
            return GPAlert(title: "Change your Settings", message: kPermissionMessage)
        }
        
        static func turnOffLocationPermission() -> GPAlert {
            let kPermissionMessage = "Go to your device settings for Instacam, tap Permissions, then turn off location access"
            return GPAlert(title: "Turn off Location Sharing", message: kPermissionMessage)
        }
        
        static func turnOffNotificationPermission() -> GPAlert {
            let kPermissionMessage = "You'll no longer receive push notifications from Instacam."
            return GPAlert(title: "Turn off Notifications", message: kPermissionMessage)
        }
        
        static func network() -> GPAlert{
            return GPAlert(title: "Network Issue!", message: "\(GConstant.kAlertTitle) has failed to retrieve data. Please check your Internet connection and try again")
        }
        //uses
        /*
         let alert = GConstant.Alert.network()
         GFunction.shared.showAlert(title: alert.title, message: alert.message)
         */
    }
}

//MARK:- UIColor
extension UIColor{
    static let AppBlueColor          = UIColor.init(red: 82/255, green: 67/255, blue: 170/255, alpha: 1)
    static let AppTitleColor          = UIColor.init(red: 23/255, green: 43/255, blue: 77/255, alpha: 1)
    static let AppBlacKButtonColor          = UIColor.init(red: 45/255, green: 45/255, blue: 45/255, alpha: 1)
    static let AppGrayColor          = UIColor.init(red: 122/255, green: 134/255, blue: 154/255, alpha: 1)
    
    static let AppGray2Color          = UIColor.init(red: 163/255, green: 163/255, blue: 164/255, alpha: 1)
    
    static let AppRedColor          = UIColor.init(red: 251/255, green: 109/255, blue: 58/255, alpha: 1)
    static let AppLightGrayColor          = UIColor.init(red: 244/255, green: 245/255, blue: 247/255, alpha: 1)
    
    static let AppBackgroundColor          = UIColor.init(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
    
    static let AppGreenColor          = UIColor.init(red: 0/255, green: 135/255, blue: 90/255, alpha: 0.8)
    
    //
    static let startServiceColor          = UIColor.init(red: 33/255, green: 164/255, blue: 83/255, alpha: 0.15)
    static let startServiceColor1          = UIColor.init(red: 33/255, green: 164/255, blue: 83/255, alpha: 1)
    static let serviceNotStartedColor          = UIColor.init(red: 163/255, green: 163/255, blue: 164/255, alpha: 0.2)
    static let serviceNotStartedColor1          = UIColor.init(red: 163/255, green: 163/255, blue: 164/255, alpha: 1)
    static let cancelledbookingColor          = UIColor.init(red: 231/255, green: 76/255, blue: 60/255, alpha: 0.2)
    static let cancelledbookingColor1          = UIColor.init(red: 231/255, green: 76/255, blue: 60/255, alpha: 1)
}

