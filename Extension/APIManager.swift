//
//  APIManager.swift
//  Extension
//
//  Created by Mr. Naveen Kumar on 26/03/21.
//

import UIKit
import Foundation
import Alamofire

class APIManager: NSObject {
    static let shared = APIManager()
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

