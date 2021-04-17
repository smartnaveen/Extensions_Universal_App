//
//  APIManager.swift
//  Extension
//
//  Created by Mr. Naveen Kumar on 24/03/21.
//

import UIKit
import Foundation
import Alamofire

class APIManagerOld: NSObject {
    
    static let shared = APIManagerOld()
//    func fetchGenericData<T:Decodable>(urlString:String, dict: [String:Any],requestType: HTTPMethod, completion: @escaping (T) -> (), failure: @escaping(String)->()){
//        let url = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
//        print(url)
//        AF.request(url, method: requestType, parameters: dict, encoding: JSONEncoding.default , headers: [:]).responseJSON { (response:AFDataResponse<Any>) in
//            print(response.debugDescription)
//            print("Response =====  ",response.result)
//
//            switch(response.result){
//            case .success(_):
//                let res = response.result.value as! [String:Any]
//                print("result \(res)")
//                if res["error"] as? Int == 1 {
////                    Global.shared.hideLoader()
////                    Global.shared.showAlert("\(res["status"]!)")
//                }else if res["type"] as? String == "Warning" {
//                    Global.shared.hideLoader()
//                    Global.shared.showAlert("\(res["message"]!)")
//                }else  if res["type"] as? String == "Error" {
//                    // Global.shared.showAlert("\(result["message"]!)")
//
//                    let data = res["data"] as! [String:Any]
//                    let error  = data["errors"] as? [String:Any]
//                    guard let msg = error!["email"] as? [String] else {
//                        return
//                    }
////                     Global.shared.hideLoader()
//                    Global.shared.showAlert(msg.first!)
//                    return
//                }
//                else{
//                    guard let data = response.data else { return }
//                    do{
//                        let userModel = try JSONDecoder().decode(T.self, from: data)
//                        completion(userModel)
//                    }catch let error {
//                        print("error \(error.localizedDescription)")
//                        failure(error.localizedDescription)
//                    }
//                }
//            case .failure(let error):
////                 Global.shared.hideLoader()
//                failure(error.localizedDescription)
////                Global.shared.showAlert(titleStr: error.localizedDescription)
//            }
//            /*
//             guard let data = response.data else { return }
//             do{
//             let userModel = try JSONDecoder().decode(T.self, from: data)
//             completion(userModel)
//             }catch let error {
//             print("error \(error.localizedDescription)")
//             failure(error.localizedDescription)
//             }
//             */
//
//        }.resume()
//    }

        

//    func requestUploadWith(endUrl: String,imageName: String, imagesData: [Data]?, parameters: [String : Any], onCompletion: (([String:Any]) -> Void)? = nil, onError: ((Error?) -> Void)? = nil){
//            //let url = "http://google.com" /* your API url */
//            print("===   url ==== ",endUrl)
//            let headers: HTTPHeaders = [
//                /* "Authorization": "your_access_token",  in case you need authorization header */
//                "Content-type": "multipart/form-data",
//            ]
//
//            AF.upload(multipartFormData: { (multipartFormData) in
//                if imagesData != nil{
//                    for (index,imageData) in imagesData!.enumerated() {
//                        multipartFormData.append(imageData, withName:  imageName, fileName: "\(self.getName())_\(index).jpeg", mimeType: "image/jpeg")
//                    }
//                }
//                for (key, value) in parameters {
//                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
//                }
//            }, to: endUrl, usingThreshold: UInt64.init(), method: .post, headers: headers, interceptor: nil, fileManager: FileManager.default, requestModifier: nil
//                . {(result) in
//                switch result{
//                case .success(let upload, _, _):
//                    upload.uploadProgress(closure: { (progress) in
//                        print("progress",progress)
//                    })
//                        upload.responseJSON { response in
//                            print(response.debugDescription)
//                            switch(response.result){
//                            case .success(_):
//                                let result = response.result.value as! [String:Any]
//                                onCompletion?(result)
////                                print(result)
//                                if ((result["error"] as? Int) == 1){
////                                    let custError: NSError = NSError(domain:.init("Custom Error") , code: 200, userInfo: [:])
////                                    onError?(custError)
//                                     Global.shared.hideLoader()
//                                    Global.shared.showAlert("error")
//                                    return
//                                }
////                                onCompletion?(response.data!)
//                            case .failure(let error):
//                                print("Error in uploading: \(error.localizedDescription)")
//                                onError?(error)
//                            }
//                        }
//                case .failure(let error):
//                    print("Error in upload: \(error.localizedDescription)")
//                    onError?(error)
//                }
//            })
//    }
//post
//upload
//delete
    
    
    
    
    // MARK:- Not used
       
   //    func handleReachability() {
   //        if NetworkReachability.shared.isNetworkAvailable{
   //            Global.shared.showLoader()
   //            let param = ["user_id": ProfileHandler.shared.id!,"message_type": "text","message": messageTV.text!] as [String : Any]
   //             let url = BASE_URL + ADD_USER_FEED
   //            APIManager.shared.fetchData(urlString: url, dict: param, requestType: .post, completion: { (result) in
   //                debugPrint(result)
   //                Global.shared.hideLoader()
   //                if result["error"] as? String == "1" {
   //                    Global.shared.showAlert("\(result["status"]!)")
   //                }else{
   //                     //Dismiss View and reload feeds
   //                      self.dismiss(animated: false, completion: nil)
   //                }
   //            }) { (error) in
   //                Global.shared.hideLoader()
   //                Global.shared.showAlert(error)
   //            }
   //        }else{
   //            //       let param = ["user_id": ProfileHandler.shared.id!,"msg_type": "text/Image","message": "message","method" : "user_feed"] as [String : Any]
   //            var imageData = [Data]()
   //            for image in imageArr{
   //                let imgData: Data = image.jpegData(compressionQuality: 0.5)!
   //                imageData.append(imgData)
   //            }
   //            let url = BASE_URL + ADD_USER_FEED
   //           // let param = ["user_id": ProfileHandler.shared.id!,"message_type": "image","caption":messageTV.text!] as [String : Any]
   //            Global.shared.showLoader()
   //
   //            APIManager.shared.requestUploadWith(endUrl: url, imageName: "message", imagesData: imageData, parameters: param, onCompletion: { (result) in
   //                Global.shared.hideLoader()
   //                debugPrint(result)
   //                if result["error"] as? String == "1"{
   //                    Global.shared.showAlert("\(result["status"]!)")
   //                }else{
   //                    //Dismiss View and reload feeds
   //                    self.dismiss(animated: false, completion: nil)
   //                }
   //            }) { (err) in
   //                Global.shared.hideLoader()
   //                Global.shared.showAlert(err!.localizedDescription)
   //            }
   //        }
   //       }
       
    
}
