//
//  APIManager.swift
//  Extension
//
//  Created by Mr. Naveen Kumar on 05/06/21.
//

import UIKit
import Alamofire
import SwiftyJSON

// MARK: - AppManager replaced with APIManager

class AppManagerNew: NSObject {
    static let shared = AppManagerNew()
    
    // MARK:- FetchData not generic means not model type
    func fetchData(urlString:String, dict: [String:Any],requestType: HTTPMethod, completion: @escaping (Any) -> (), failure: @escaping(String)->()){
        let url = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        print(url)
        let headers: HTTPHeaders = [
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1ZmQ5YWY1ODliMzM3NWE5MTNlZTBjOGQiLCJmaXJzdG5hbWUiOiJQYW5rYWoiLCJsYXN0bmFtZSI6Ikt1bWFyIiwiZW1haWwiOiJzZnMucGFua2FqMjBAZ21haWwuY29tIiwiZ2VuZGVyIjoibWFsZSIsImRvYiI6IjE5OTUtMTItMTZUMDA6MDA6MDAuMDAwWiIsImNvdW50cnlfY29kZSI6Iis5MSIsInBob25lX251bWJlciI6Ijg3MDA1MzkzNjYiLCJwcm9maWxlIjoiIiwidXNlcl90eXBlIjoibWVuIiwiZGVmYXVsdF9wcm9maWxlIjp0cnVlLCJhZGRyZXNzX2lkIjoiIiwiaWF0IjoxNjE0NTkxNjEzLCJhdWQiOiJTcVRvc2RzZEtlTnBSb0plQ3QifQ.Ao8EGV6WTnsXSAot9Ng9ei4Uj2NoBhHStEQFhmFI89Y",
              ]
        AF.request(url, method: requestType, parameters: dict, encoding: URLEncoding.default , headers: nil).responseJSON { (response: AFDataResponse<Any>) in
            switch(response.result){
            case .success(let response):
                let json = JSON(response)
                print("JSON: \(json)")
                completion(response)
            case .failure(let error):
                failure(error.localizedDescription)
            }
        }
    }
}
