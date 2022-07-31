//
//  UserModel.swift
//  Extension
//
//  Created by Mr. Naveen Kumar on 05/06/21.
//


import UIKit
import SwiftyJSON

class UserModel1: NSObject {
    var page             = Int()
    var perPage          = Int()
    var total            = Int()
    var totalPages       = Int()
    var data             = [UserData]()
    var support          = SupportLink()

    
    override init() {
    }
    
    init(obj: JSON) {
        self.page        = obj["page"].intValue
        self.perPage     = obj["per_page"].intValue
        self.total       = obj["total"].intValue
        self.totalPages  = obj["total_pages"].intValue
        
        if obj["data"].exists() {
            for obj in obj["data"].arrayValue {
                let objData = UserData.init(obj: obj)
                self.data.append(objData)
            }
        }
        
        if obj["support"].exists() {
            self.support = SupportLink.init(obj: obj["support"])
        }
        
    }
}

class UserData: NSObject{
    var id           = Int()
    var email        = String()
    var first_name   = String()
    var last_name    = String()
    var avatar       = String()
    var images       = [String]()

    override init() {
    }

    init(obj: JSON) {
        self.id         = obj["id"].intValue
        self.email      = obj["email"].stringValue
        self.first_name = obj["first_name"].stringValue
        self.last_name  = obj["last_name"].stringValue
        self.avatar     = obj["avatar"].stringValue
        
        for img in obj["images"].arrayValue {
            self.images.append(img.stringValue)
        }
    }

}

class SupportLink: NSObject {
    var url    = String()
    var text   = String()
    
    override init() {
    }
    
    init(obj: JSON) {
        self.url         = obj["url"].stringValue
        self.text         = obj["text"].stringValue
    }

}
