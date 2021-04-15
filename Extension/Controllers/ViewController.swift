//
//  ViewController.swift
//  Extension
//
//  Created by Mr. Naveen Kumar on 11/03/21.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    let imageArr: [UIImage] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.init(105, 60, 114)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        var imageData = [Data]()
        for image in imageArr{
            if let imgData: Data = image.jpegData(compressionQuality: 0.5) {
                imageData.append(imgData)
            }
        }

        let param = ["user_id": ""]

        requestUploadWith(endURL: "IMGUR_BASE_URL", imageName: "message", imagesData: imageData, parameters: param) { (result) in
            debugPrint(result)
//            if result["error"] as? String == "1"{
//                Global.shared.showAlert("\(result["status"]!)")
//            }else{
//                //Dismiss View and reload feeds
//                self.dismiss(animated: false, completion: nil)
//            }
        } onError: { (error) in
            if let err = error {
                Global.shared.showAlert(title: err.localizedDescription, message: "")
            }
        }
    }
}


extension ViewController {
    //MARK: - Upload Image
    private func requestUploadWith(endURL: String, imageName: String,  imagesData: [Data]?, parameters: [String : Any], onCompletion: ((Any) -> Void)? = nil, onError: ((Error?) -> Void)? = nil) {
        //let url = "http://google.com" /* your API url */
        print("===   url ==== ", endURL)
        let headers: HTTPHeaders = [
            /* "Authorization": "your_access_token",  in case you need authorization header */
            "Content-type": "multipart/form-data",
        ]
                AF.upload( multipartFormData: { multipartFormData in
                    if imagesData != nil{
                        for (index,imageData) in imagesData!.enumerated() {
                            multipartFormData.append(imageData, withName:  imageName, fileName: "\(self.getName())_\(index).jpeg", mimeType: "image/jpeg")
                        }
                    }
                    for (key, value) in parameters {
                        multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                    }
                },
                to: endURL, usingThreshold: UInt64.init(), method: .post, headers: headers)
                .response { response in
                    switch response.result {
                    case .success(_):
                        let result = response.result
                        onCompletion?(result)
                    print(result)
                       // if ((result["error"] as? Int) == 1){
                            //                                    let custError: NSError = NSError(domain:.init("Custom Error") , code: 200, userInfo: [:])
                            //                                    onError?(custError)
                            //Global.shared.hideLoader()
                          //  Global.shared.showAlert("error")
                            return
//                    }
                    case .failure(let error):
                        print("Error in uploading: \(error.localizedDescription)")
                        onError?(error)
                        }
                }
        }
    
    
    func getName()->String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd_HH:mm:ss"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        print(formatter.string(from: date))
        return  formatter.string(from: date)
    }
}


// MARK:- POST API
extension ViewController {
   func handleAPI() {
       let safeUrl = "https://reqres.in/api/register"
     //  let param = ["name": "Naveen Kumar", "job": "leader"] as [String : Any]
       
       let param = ["email": "eve.holt@reqres.in", "password": "pistol"]

       APIManager.shared.fetchData(urlString: safeUrl, dict: param, requestType: .post) { (result) in
           debugPrint(result)
           if let safeResponseDict = result as? [String: Any] {
               debugPrint(safeResponseDict["token"]!)
           }
       } failure: { (error) in
           Global.shared.showAlert(title: error, message: "")
       }
   }
}
