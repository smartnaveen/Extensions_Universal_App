//
//  APIManager.swift
//  Extension
//
//  Created by Mr. Naveen Kumar on 26/03/21.
//

import UIKit
import Foundation
import Alamofire
import SVProgressHUD
import AVFoundation


class APIManager: NSObject {
    static let shared = APIManager()
    
    var player: AVPlayer?
    
     // MARK:- FetchData not generic means not model type
    func fetchData(urlString:String, dict: [String:Any],requestType: HTTPMethod, completion: @escaping (Any) -> (), failure: @escaping(String)->()){
        let url = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        print(url)
        AF.request(url, method: requestType, parameters: dict, encoding: URLEncoding.default , headers: nil).responseJSON { (response: AFDataResponse<Any>) in
            ///JSONEncoding.default
            print("response.debugDescription===",response.debugDescription)
            print("Response =====  ",response.result)
            switch(response.result){
            case .success(let response):
                print("result \n \(response)")
                    completion(response)
            case .failure(let error):
                failure(error.localizedDescription)
                Global.shared.showAlert(title: "Error", message: error.localizedDescription)
            }
        }
    }

    
    
    // MARK:- FetchGenericData using model type
    func fetchGenericData<T:Decodable>(urlString:String, dict: [String:Any],requestType: HTTPMethod, completion: @escaping (T) -> (), failure: @escaping(String)->()){
        let url = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        print(url)
        AF.request(url, method: requestType, parameters: dict, encoding: URLEncoding.default , headers: [:]).responseJSON { (response:AFDataResponse<Any>) in
            print(response.debugDescription)
            print("Response =====  ",response.result)
            switch(response.result){
            case .success(let res):
                print("result \(res)")
                guard let data = response.data else { return }
                do{
                    let userModel = try JSONDecoder().decode(T.self, from: data)
                    completion(userModel)
                }catch let error {
                    print("error \(error.localizedDescription)")
                    failure(error.localizedDescription)
                }
            case .failure(let error):
                failure(error.localizedDescription)
            }
        }.resume()
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
    
    
    // MARK:- For downloading audio From Url
        func downloadMediaFile(_ musicURL: String){
            AF.request("\(musicURL)").downloadProgress(closure : { (progress) in
                print(progress.fractionCompleted)
                SVProgressHUD.showProgress(Float(progress.fractionCompleted))
            }).responseData{ (response) in
                print(response)
                SVProgressHUD.dismiss()
                self.playSound(soundUrl: musicURL)
            }
        }
        
        func playSound(soundUrl: String) {
            guard let url = URL.init(string: soundUrl) else { return }
            let playerItem = AVPlayerItem.init(url: url)
            player = AVPlayer.init(playerItem: playerItem)
            player?.play()
        }
    
    
    //new
//    func requestUploadWith(endUrl: String, imageName: String, imagesData: [Data]?, parameters: [String : Any], onCompletion: ((Any) -> Void)? = nil, onError: ((Error?) -> Void)? = nil){
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
//                    multipartFormData.append(imageData, withName:  imageName, fileName: "\(self.getName())_\(index).jpeg", mimeType: "image/jpeg")
//                }
//                }
//                for (key, value) in parameters {
//                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
//                }
//
//            }, to: endUrl, usingThreshold: UInt64.init(), method: .post, headers: headers) { (result) in
//                switch result{
//
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
//            }
//        }
    
}

 // MARK:- HOW CAN I USED GET API
/*
 -------------------------- FOR GENRIC API --------------------------
 *************  Response are comming array of dictionary -----> [{}]
 let safeUrl = "https://api.unsplash.com/photos/?client_id=kutQ6I5P-RcvxF6VqQ1oMad7F15hdGrSVPmutPRbAUw"
 APIManager.shared.fetchGenericData(urlString: safeUrl, dict: [:], requestType: .get) { (model: [Person]) in
     for i in model{
         debugPrint(i.user.profile_image.large)
     }
 } failure: { (error) in
     debugPrint(error)
 }

 struct Person: Codable {
     let user: User
 }

 struct User: Codable {
     let profile_image: Large
 }

 struct Large: Codable {
     let large: String
     
 }
 
 --------------------------  FETCHDATA NOT GENERIC  --------------------------
 APIManager.shared.fetchData(urlString: safeUrl, dict: [:], requestType: .get) { (result) in
     debugPrint(result)
     if let safeResponse = result as? [Any]{
         for safeData in safeResponse{
             if let safeDataDict = safeData as? [String: Any] {
                 debugPrint(safeDataDict["alt_description"]!)
             }
         }
     }
 } failure: { (error) in
     debugPrint(error)
 }
 
 */


// MARK:- HOW CAN I USED POST API
/*
 // Post is used for data send on server with using param
 
 //-------------------------- FOR GENRIC API --------------------------
 let safeUrl = "https://reqres.in/api/register"
 let param = ["name": "Naveen Kumar", "job": "leader"] as [String : Any]
 
 APIManager.shared.fetchGenericData(urlString: safeUrl, dict: param, requestType: .post) { (model: DemoModel ) in
 print(model.id, model.token)
 } failure: { (error) in
 Global.shared.showAlert(title: error, message: "")
 }
 
 
 struct DemoModel: Codable {
     let id: Int
     let token: String
 }
 
 struct demoData: Codable {
     let first_name: String
 }
 
 
 --------------------------  FETCHDATA NOT GENERIC  --------------------------
 let safeUrl = "https://reqres.in/api/register"
 let param = ["email": "eve.holt@reqres.in", "password": "pistol"]
 APIManager.shared.fetchData(urlString: safeUrl, dict: param, requestType: .post) { (result) in
     debugPrint(result)
     if let safeResponseDict = result as? [String: Any] {
         debugPrint(safeResponseDict["token"]!)
     }
 } failure: { (error) in
     Global.shared.showAlert(title: error, message: "")
 }
 
 */
