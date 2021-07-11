//
//  WebKit.swift
//  Extension
//
//  Created by Naveen Kumar on 07/07/21.
//

import Foundation
import WebKit

/*
 Steps are:-
 1. import Webkit (Apple Native Element)
 2. In Storyboard drag "WebkitView" inside controller
 
 
 @IBOutlet weak var webView: WKWebView!

 override func viewDidLoad() {
     super.viewDidLoad()
     if let safeURL = URL(string: "https://www.apple.com/in") {
         let requestObj = URLRequest(url: safeURL)
         webView.load(requestObj)
     }
 }
 
 // Load HTML File In Webkit View
 override func viewDidLoad() {
     super.viewDidLoad()
     if let filePath = Bundle.main.url(forResource: "help", withExtension: "html") {
       let request = NSURLRequest(url: filePath)
       webView.load(request as URLRequest)
     }
}
 
*/
