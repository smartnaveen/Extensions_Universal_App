//
//  Localizable.swift
//  Extension
//
//  Created by Naveen Kumar on 07/07/21.
//

import Foundation
import UIKit

/*
 There are Two way for localizable string :-
 1. Programmatically
 2. Storyboard
 
 1. Programmatically
 Steps: - 1. First Create String file with name of Localizable.strings. (cmd+n)
          2. Go to Project in Localization section add languages as preffered in Localizable strings.
 
 //        let title = NSLocalizedString("Hello MacBook Pro", comment: "")
 //        let btn1 = NSLocalizedString("Button", comment: "")
 //        btn.setTitle(btn1, for: .normal)
 //        lblTitle.text = title
 
 
 2. Storyboard
 Steps: - 1. First Go to project and add languages in Localization section.
          2. Go to Storyboard and select UI Elements and add Languages as you want in first tab of inspector pane.
          3. Created Object-id
          4. Replaces text-value with the localize value strings.

 
 */


// MARK: - For More Help Docs
//https://medium.com/lean-localization/ios-localization-tutorial-938231f9f881

// MARK: - 3rd party
/*
 
 // App Delegate
 let langStr = Locale.current.languageCode
 print(langStr!)
 Localize.setCurrentLanguage(langStr!)
 
 lblLogout.text = "Logout".localized()
 btn.setTitle("Hello world".localized(), for: .normal)
 */
