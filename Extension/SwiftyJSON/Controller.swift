//
//  Controller.swift
//  Extension
//
//  Created by Mr. Naveen Kumar on 05/06/21.
//

import UIKit
import SwiftyJSON

class Controller: UIViewController {
    
    var objUserModel = UserModel()
    

    func apiHandle() {
        let url = "https://busk2ztzsh.execute-api.us-east-1.amazonaws.com/api/customer/show-all-active-stylist"
        var parameter: [String: Any] = [String: Any]()
        parameter["page"]            = 1
        parameter["stylist_level"]   = "advanced
        
        
        AppManager.shared.fetchData(urlString: url, dict: parameter, requestType: .post) { (result) in
            let json = JSON(result)
            if json["status"].intValue == 200 {
                print(json["data"])
                for i in json["data"].arrayValue{
                    print(i["firstname"].stringValue)
                }
                self.objUserModel = UserModel.init(obj: json)
//                self.stylistTableView.reloadData() // reload tableView
            }else if json["status"].doubleValue == 401 {
                print(json["message"])
            }
            
        } failure: { (error) in
            print(error)
        }

    }

}
