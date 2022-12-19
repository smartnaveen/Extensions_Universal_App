//
//  ColorPicker.swift
//  Extension
//
//  Created by Naveen Kumar on 19/12/22.
//

import Foundation
import UIKit

public protocol ColorPickerDelegate: class {
    func didSelect(color: UIColor?)
}

@available(iOS 14.0, *)
class ColorPicker: NSObject, UIColorPickerViewControllerDelegate {
    static let shared = ColorPicker()
    
    var picker = UIColorPickerViewController()
    var delegate: ColorPickerDelegate?
    
     func openColorPicker(presentationController: UIViewController) {
        picker.delegate = self
        presentationController.present(picker, animated: true, completion: nil)
    }
}

@available(iOS 14.0, *)
extension ColorPicker {
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        self.delegate?.didSelect(color: viewController.selectedColor)
    }
    
    //  Called on every color selection done in the picker.
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        self.delegate?.didSelect(color: viewController.selectedColor)
    }
}


// MARK: - How To use Color Picker Tapped on Button
/*
 @IBAction func btnOpenColorPicker(_ sender: Any) {
     if #available(iOS 14.0, *) {
         ColorPicker.shared.openColorPicker(presentationController: self)
         ColorPicker.shared.delegate = self
     } else {
         // Fallback on earlier versions
     }
 }
 
 // Delegate method inherit
 func didSelect(color: UIColor?) {
     self.view.backgroundColor = color
 }
 
 */

