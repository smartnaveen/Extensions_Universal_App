//
//  GFunction.swift
//  watch
//
//  Created by Mr. Naveen Kumar on 23/05/21.
//

import Foundation
import UIKit

class GFunction: NSObject {
    static let shared = GFunction()

     // MARK:- Show Alert Globally
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.view.tintColor = UIColor.init(named: "AppOrangeColor") ?? UIColor.green
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (action) in
            print("Dismiss")
        }))
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
     // MARK:- ImageOfUIView (UIView Screenshot)
    /*
     let img = GFunction.shared.imageOfUIView(with: self.view)
     */
    func imageOfUIView(with view: UIView) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
        defer { UIGraphicsEndImageContext() }
        if let context = UIGraphicsGetCurrentContext() {
            view.layer.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            return image
        }
        return nil
    }
}
