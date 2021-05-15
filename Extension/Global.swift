//
//  Global.swift
//  Extension
//
//  Created by Mr. Naveen Kumar on 19/03/21.
//

import Foundation
import UIKit

class Global: NSObject {
   static let shared = Global()
    
    let colorSchemeGreen = UIColor.green
    let colorSchemeYellow = UIColor.yellow
    let primarycolorScheme = UIColor.blue
    let colorSchemeWhite = UIColor.white
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.view.tintColor = UIColor.init(named: "AppOrangeColor") ?? UIColor.green
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (action) in
            print("Dismiss")
        }))
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController?.present(alert, animated: true, completion: nil)
    }
}

let INTERNET_ERROR = "Internet not available."


let BASE_URL = "https://api.unsplash.com/photos/"
let API_KEY = "kutQ6I5P-RcvxF6VqQ1oMad7F15hdGrSVPmutPRbAUw"


//-----------Send the link to your testers, clients, friends or even use it yourself. ------------------------
// Beta Link
/*
 1.  https://www.installonair.com/
 2.  https://betafamily.com/supersend
 3.  https://www.diawi.com/
 
 NOTE - Upload appDsysm file by terminal (Screenshot are avilable in project)
 
 */
