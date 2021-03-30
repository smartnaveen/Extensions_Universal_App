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
    func fetchData(urlString:String, dict: [String:Any],requestType: HTTPMethod, completion: @escaping ([String:Any]) -> (), failure: @escaping(String)->()){
        let url = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        print(url)
        AF.request(url, method: requestType, parameters: dict, encoding: URLEncoding.default , headers: nil).responseJSON { (response: AFDataResponse<Any>) in
            ///JSONEncoding.default
            print("response.debugDescription===",response.debugDescription)
            print("Response =====  ",response.result)
            switch(response.result){
            case .success(let response):
                print("result \n \(response)")
                if let safeResponse = response as? [String: Any] {
                    completion(safeResponse)
                }
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
        AF.request(url, method: requestType, parameters: dict, encoding: JSONEncoding.default , headers: [:]).responseJSON { (response:AFDataResponse<Any>) in
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
