//
//  PullToRefresh.swift
//  Extension
//
//  Created by Mr. Naveen Kumar on 16/05/21.
//

import Foundation
import UIKit

/*
 var refreshControl = UIRefreshControl()

 override func viewDidLoad() {
     super.viewDidLoad()
     
     refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
     tableView.refreshControl = refreshControl
 }

 @objc func refresh(_ sender: UIRefreshControl) {
    // Code to refresh table view
     print("Hi")
     arrData.append("Examples, \(arrData.count)")
     refreshControl.endRefreshing()
     tableView.reloadData()
 }
 */



// MARK: - Show RefreshControl in Footerview of tableview
/*
 
 let spinner = UIActivityIndicatorView(style: .medium)

 override func viewDidLoad() {
 super.viewDidLoad()
     spinner.color = UIColor.darkGray
     spinner.hidesWhenStopped = true
     tableView.tableFooterView = spinner
 }

 
 func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
     if indexPath.row == 20 {
         spinner.startAnimating()
     }
 }
 
 
 // For hide it.
 spinner.stopAnimating()

 
 */
