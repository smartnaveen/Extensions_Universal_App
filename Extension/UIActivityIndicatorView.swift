//
//  UIActivityIndicatorView.swift
//  Extension
//
//  Created by Mr. Naveen Kumar on 15/05/21.
//

import Foundation
import UIKit

// ========================================================================
 // MARK:- Storyboard
// Method - 1
//@IBOutlet weak var activityIndicator: UIActivityIndicatorView!

var isAnimate: Bool = true

/*
 @IBAction func clickMe(_ sender: UIButton) {
     activityIndicator.style = .large
     activityIndicator.hidesWhenStopped = true

     if isAnimate {
         activityIndicator.startAnimating()
         activityIndicator.color = .green
     }else{
         activityIndicator.stopAnimating()
     }
     isAnimate = !isAnimate
 }
 */

// ========================================================================
 // MARK:- Extension
// Method - 2
extension UIActivityIndicatorView {
    convenience init(activityIndicatorStyle: UIActivityIndicatorView.Style, color: UIColor, placeInTheCenterOf parentView: UIView) {
        self.init(style: activityIndicatorStyle)
        center = parentView.center
        self.color = color
        parentView.addSubview(self)
    }
}
 // MARK:- This Code For used Extension Of UIActivitiyIndicatorView
/*
 let wait = UIActivityIndicatorView(activityIndicatorStyle: .large, color: .green, placeInTheCenterOf: view)
     wait.startAnimating()
 
 */


// ========================================================================
 // MARK:- Make Custom IndicatorView With Label
// Method - 3
/*
 func showCustomIndicatorView(parentView: UIView) {
     let childView = UIView(frame: CGRect(x: 0, y: 0, width: 250, height: 50))
     childView.backgroundColor = UIColor.white
     childView.layer.cornerRadius = 10
     childView.tag = 100
     
     let wait = UIActivityIndicatorView(frame: CGRect(x: 20, y: 0, width: 50, height: 50))
     wait.color = UIColor.black
     wait.style = .medium
     wait.hidesWhenStopped = false
     wait.startAnimating()
     
     let text = UILabel(frame: CGRect(x: 80, y: 0, width: 200, height: 50))
     text.text = "Processing..."
     
     childView.addSubview(wait)
     childView.addSubview(text)
     childView.center = parentView.center
     parentView.addSubview(childView)
 }
 
 
 func hideCustomIndicatorView() {
     if let viewWithTag = self.view.viewWithTag(100) {
         viewWithTag.removeFromSuperview()
     }else{
         print("No!")
     }
 }
 
 // How Can I Used
 @IBAction func showCustomIndicator(_ sender: UIButton) {
     if isAnimate {
         showCustomIndicatorView(parentView: view)
         
     }else {
         hideCustomIndicatorView()
     }
     isAnimate = !isAnimate
 }
*/
