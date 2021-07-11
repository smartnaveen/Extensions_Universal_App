//
//  CalendarDateRangePickerViewController.swift
//  Extension
//
//  Created by Naveen Kumar on 07/07/21.
//

import Foundation
import UIKit
import CalendarDateRangePickerViewController

/*
 @IBOutlet weak var lbl: UILabel!

 
 @IBAction func didTapped(_ sender: UIButton) {
     let dateRangePickerViewController = CalendarDateRangePickerViewController(collectionViewLayout: UICollectionViewFlowLayout())
     dateRangePickerViewController.delegate = self
     dateRangePickerViewController.minimumDate = Date()
     dateRangePickerViewController.maximumDate = Calendar.current.date(byAdding: .year, value: 2, to: Date())
     dateRangePickerViewController.selectedStartDate = Date()
     dateRangePickerViewController.selectedEndDate = Calendar.current.date(byAdding: .day, value: 10, to: Date())
     let navigationController = UINavigationController(rootViewController: dateRangePickerViewController)
     self.navigationController?.present(navigationController, animated: true, completion: nil)
     
 }

 
 // Extension
 extension ViewController: CalendarDateRangePickerViewControllerDelegate {
     func didTapCancel() {
         self.navigationController?.dismiss(animated: true, completion: nil)
     }
     
     func didTapDoneWithDateRange(startDate: Date!, endDate: Date!) {
         let dateFormatter = DateFormatter()
 //        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
         dateFormatter.dateFormat = "yyyy-MM-dd"
         lbl.text = dateFormatter.string(from: startDate) + " to " + dateFormatter.string(from: endDate)
         print(dateFormatter.string(from: startDate))
         print(dateFormatter.string(from: endDate))
         self.navigationController?.dismiss(animated: true, completion: nil)
     }
     
 }
 
 
 */
