//
//  TableViewHeight.swift
//  Extension
//
//  Created by Naveen Kumar on 03/12/23.
//

/*
override func viewDidLoad() {
    super.viewDidLoad()
    tableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
}

override func viewWillDisappear(_ animated: Bool) {
    tableView.removeObserver(self, forKeyPath: "contentSize")
}

override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize"{
            if object is UITableView{
                if let newValue = change?[.newKey]{
                    let newSize = newValue as! CGSize
                    heightOfTableViewConstraint.constant = newSize.height
                }
            }
        }
    }
*/
