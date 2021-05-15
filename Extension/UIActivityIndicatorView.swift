//
//  UIActivityIndicatorView.swift
//  Extension
//
//  Created by Mr. Naveen Kumar on 15/05/21.
//

import Foundation
import UIKit

 // MARK:- Storyboard
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


 // MARK:- Extension
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
