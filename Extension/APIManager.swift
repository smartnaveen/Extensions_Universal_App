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
        //  let token = AppManager.getAuthenticationToken()
        let headers: HTTPHeaders = [
                  /* "Authorization": "your_access_token",  in case you need authorization header */
//                  "Content-type": "multipart/form-data",
//            "Content-type": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1ZmQ5YWY1ODliMzM3NWE5MTNlZTBjOGQiLCJmaXJzdG5hbWUiOiJQYW5rYWoiLCJsYXN0bmFtZSI6Ikt1bWFyIiwiZW1haWwiOiJzZnMucGFua2FqMjBAZ21haWwuY29tIiwiZ2VuZGVyIjoibWFsZSIsImRvYiI6IjE5OTUtMTItMTZUMDA6MDA6MDAuMDAwWiIsImNvdW50cnlfY29kZSI6Iis5MSIsInBob25lX251bWJlciI6Ijg3MDA1MzkzNjYiLCJwcm9maWxlIjoiIiwidXNlcl90eXBlIjoibWVuIiwiZGVmYXVsdF9wcm9maWxlIjp0cnVlLCJhZGRyZXNzX2lkIjoiIiwiaWF0IjoxNjE0NTkxNjEzLCJhdWQiOiJTcVRvc2RzZEtlTnBSb0plQ3QifQ.Ao8EGV6WTnsXSAot9Ng9ei4Uj2NoBhHStEQFhmFI89Y",
              ]
        AF.request(url, method: requestType, parameters: dict, encoding: URLEncoding.default , headers: headers).responseJSON { (response: AFDataResponse<Any>) in
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
       // let token = AppManager.getAuthenticationToken()
        let headers: HTTPHeaders = [
                  /* "Authorization": "your_access_token",  in case you need authorization header */
//                  "Content-type": "multipart/form-data",
//            "Content-type": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1ZmQ5YWY1ODliMzM3NWE5MTNlZTBjOGQiLCJmaXJzdG5hbWUiOiJQYW5rYWoiLCJsYXN0bmFtZSI6Ikt1bWFyIiwiZW1haWwiOiJzZnMucGFua2FqMjBAZ21haWwuY29tIiwiZ2VuZGVyIjoibWFsZSIsImRvYiI6IjE5OTUtMTItMTZUMDA6MDA6MDAuMDAwWiIsImNvdW50cnlfY29kZSI6Iis5MSIsInBob25lX251bWJlciI6Ijg3MDA1MzkzNjYiLCJwcm9maWxlIjoiIiwidXNlcl90eXBlIjoibWVuIiwiZGVmYXVsdF9wcm9maWxlIjp0cnVlLCJhZGRyZXNzX2lkIjoiIiwiaWF0IjoxNjE0NTkxNjEzLCJhdWQiOiJTcVRvc2RzZEtlTnBSb0plQ3QifQ.Ao8EGV6WTnsXSAot9Ng9ei4Uj2NoBhHStEQFhmFI89Y",
              ]
        AF.request(url, method: requestType, parameters: dict, encoding: URLEncoding.default , headers: headers).responseJSON { (response:AFDataResponse<Any>) in
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
    
    
    // MARK:- Upload Images on Server with filename
     func requestUploadWith(endURL: String, parameters: [String : Any], imagesData: [Data]?, imageName: String, progressCompletion: @escaping (_ percent: Float) -> Void, onCompletion: @escaping (_ result: Any) -> Void, onError: @escaping (_ error: Error) -> Void){
        print("===   url ==== ", endURL)
        let headers: HTTPHeaders = [
            /* "Authorization": "your_access_token",  in case you need authorization header */
            "Content-type": "multipart/form-data",
            "Authorization": "4d50b81f78cafb2b4a1cddfe9b1260f8d2e318c7",
            
        ]
        AF.upload(
            multipartFormData: { multipartFormData in
                if imagesData != nil{
                    for (index,imageData) in imagesData!.enumerated() {
                        multipartFormData.append(imageData, withName: imageName, fileName: "\(self.getName())_\(index).png", mimeType: "image/jpeg")
                    }
                }
                
                for (key, value) in parameters {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
            },
            to: endURL, usingThreshold: UInt64.init(), method: .post, headers: headers)
            .uploadProgress { progress in
                progressCompletion(Float(progress.fractionCompleted))
            }
            .response { response in
                debugPrint(response)
                switch response.result{
                case .success(let data):
                    onCompletion(data!)
                case .failure(let error):
                    onError(error)
                }
            }
    }
 
 // MARK:- Get current Data with Time
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
    // downloadMediaFile(putURL) -> call the function when download from url
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
//Another Way - 1
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
 
//Another Way - 2
   let parameter = ["user_id": "5fd9af589b3375a913ee0c8d", "preference": ["men", "women"]] as [String : Any]

        APIManager.shared.fetchData(urlString: APIConstant.setPreference(), dict: parameter, requestType: .post) { (result) in
            if let safeResult = result as? [String: Any] {
                if let statusCode = safeResult["status"] as? Int, let message = safeResult["message"] as? String {
                    if statusCode == 401 {
                        Global.shared.showAlert(title: GConstant.kAlertTitle, message: message)
                    }else {
                        if statusCode == 200 {
                            Global.shared.showAlert(title: GConstant.kAlertTitle, message: message)
                        }
                    }
                }
            }
        } failure: { (error) in
            debugPrint(error)
            Global.shared.showAlert(title: GConstant.kAlertTitle, message: error)
        }

 */


// MARK:- HOW CAN I USED UPLOAD IMAGES/DATA ON SERVER
/*
 
 var imageArr: [UIImage] = []

 imageArr.append(UIImage(named: "naveenPhotos.jpg")!)

 var imageData = [Data]()
 for image in imageArr{
     if let imgData: Data = image.jpegData(compressionQuality: 0.5) {
         imageData.append(imgData)
     }
 }
 
 let safeURL = "https://api.imgur.com/3/upload"
 let param = ["image": imageArr.first!] as [String : Any]
 
 
 requestUploadWith(endURL: safeURL, parameters: param, imagesData: imageData, imageName: "image") { (percent) in
     print("Status: \(percent)")
 } onCompletion: { (result) in
     print(result)
 } onError: { (error) in
     Global.shared.showAlert(title: error.localizedDescription, message: "")
 }
 
 */
