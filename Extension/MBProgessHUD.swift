//
//  MBProgessHUD.swift
//  Extension
//
//  Created by Mr. Naveen Kumar on 30/05/21.
//

import Foundation
import UIKit
import MBProgressHUD


extension UIViewController {
    func showHUD(progressLabel:String?){
        DispatchQueue.main.async{
            let progressHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
            //            progressHUD.animationType = .zoom
            //            progressHUD.backgroundColor = .red
            //            progressHUD.tintColor = .blue
            //                        progressHUD.isSquare = true
            progressHUD.contentColor = .orange
            //            progressHUD.mode = .indeterminate //Acitiviy Indicator View
            progressHUD.mode = .determinateHorizontalBar // Horizontal Bar
           // progressHUD.progress = progress ?? 0  // Porgess Range 0...1
            
            //            progressHUD.mode = .annularDeterminate // Circular
            //            progressHUD.mode = .text //only show Text
            progressHUD.label.text = progressLabel
            progressHUD.removeFromSuperViewOnHide = true

        }
    }
    func dismissHUD(isAnimated:Bool) {
        DispatchQueue.main.async{
            MBProgressHUD.hide(for: self.view, animated: isAnimated)
        }
    }
}


 // MARK:- How Can I used
/*
 //For Show
 self.showHUD(progressLabel: "Loading...")
 
 //For Dismiss
 self.dismissHUD(isAnimated: true)
 */
