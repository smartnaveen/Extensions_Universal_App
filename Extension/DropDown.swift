//
//  DropDown.swift
//  Extension
//
//  Created by Mr. Naveen Kumar on 30/05/21.
//

import UIKit
import DropDown

 // MARK:- Make DropDown
/*
 let dropDown = DropDown()
 
 DropDown.startListeningToKeyboard()  // In DidfinishLaunching

 
 
 func setUpDropDown() {
 dropDown.anchorView = countryTextField // UIView or UIBarButtonItem
 dropDown.dataSource = ["Car", "Motorcycle", "Truck","Car", "Motorcycle","Car", "Motorcycle", "Truck","Car", "Motorcycle"]
 dropDown.cellNib = UINib(nibName: "MyCell", bundle: nil)
 
 
 // Notes - Make A xib Cell for Image just paste "DropDownCell" In subclass of CocoaTouch.
 dropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
 guard let cell = cell as? MyCell else { return }
 // Setup your custom UI components
 cell.logoImageView.image = UIImage(systemName: "flag.fill")
 }
 
 
 // Notes- If Talking About Label Connection outlet connected to
  Referencing Outlet which classes already in DropDown Pods.
 
 
 //                 Action triggered on selection
 dropDown.selectionAction = {  (index: Int, item: String) in
 print("Selected item: \(item) at index: \(index)")
 self.countryTextField.text = item
 }
 
 // Will set a custom width instead of the anchor view width
 //        dropDownLeft.width = 200
 
 DropDown.appearance().setupCornerRadius(10) // available since v2.3.6
 
 DropDown.appearance().textColor = UIColor.black
 DropDown.appearance().selectedTextColor = UIColor.red
 DropDown.appearance().textFont = UIFont.systemFont(ofSize: 15)
 DropDown.appearance().backgroundColor = UIColor.white
 DropDown.appearance().selectionBackgroundColor = UIColor.lightGray
 DropDown.appearance().cellHeight = 60
 dropDown.direction = .bottom
 dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
 dropDown.show()
 }
 
 */




 // MARK:- Custom XIB For Configure Cell
/*
 import UIKit
 import DropDown

 class MyCell: DropDownCell {

     @IBOutlet weak var logoImageView: UIImageView!
     
     override func awakeFromNib() {
         super.awakeFromNib()
     }

     override func setSelected(_ selected: Bool, animated: Bool) {
         super.setSelected(selected, animated: animated)
     }
     
 }
 */

