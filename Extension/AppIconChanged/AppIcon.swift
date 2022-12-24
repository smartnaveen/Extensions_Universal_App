//
//  AppIcon.swift
//  Extension
//
//  Created by Naveen Kumar on 24/12/22.
//

import Foundation
import UIKit

//Change your App Icon

// PList add item
/*
<key>CFBundleIcons</key>
<dict>
    <key>CFBundleAlternateIcons</key>
    <dict>
        <key>AppIcon-2</key>
        <dict>
            <key>CFBundleIconFiles</key>
            <array>
                <string>img</string>
            </array>
        </dict>
        <key>AppIcon-3</key>
        <dict>
            <key>CFBundleIconFiles</key>
            <array>
                <string>img1</string>
            </array>
        </dict>
    </dict>
</dict>
 
 
 // Button Action
 @IBAction func btnGot(_ sender: Any) {
     changeIcon(to: "AppIcon-2")
 }
 
 
 func changeIcon(to name: String?) {
     guard UIApplication.shared.supportsAlternateIcons else {
         return;
     }
     //Change the icon to a specific image with given name
     UIApplication.shared.setAlternateIconName(name) { (error) in
         if let error = error {
             print("App icon failed to due to \(error.localizedDescription)")
         } else {
             print("App icon changed successfully.")
         }
     }
 }
 
*/
