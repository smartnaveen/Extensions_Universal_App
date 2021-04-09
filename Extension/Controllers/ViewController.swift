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
        
    }
    
    func handleAPI() {
        //let url = "https://api.unsplash.com/photos/?client_id=kutQ6I5P-RcvxF6VqQ1oMad7F15hdGrSVPmutPRbAUw"
        let param = ["id": "8pb7Hq539Zw"] as [String : Any]
        let url = BASE_URL+"?"+"client_id="+API_KEY
    }
    
    
    
    
}



