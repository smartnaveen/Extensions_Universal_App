//
//  ViewController.swift
//  Extension
//
//  Created by Mr. Naveen Kumar on 11/03/21.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.init(105, 60, 114)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if NetworkReachability.shared.isNetworkAvailable  {
            print("Net is avilable")
        }else {
            print("no internet")
        }

    }
}

