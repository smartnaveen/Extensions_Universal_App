//
//  Post.swift
//  Firestore Demo
//
//  Created by Naveen Kumar on 18/10/21.
//

import Foundation
import UIKit
import SwiftyJSON
import Firebase


class PostModel: NSObject {
    var id = Int()
    var firstName = String()
    var LastName = String()
    var imgURL = String()

    
    override init() {
    }
    
    // Get Data
    
    init(obj: JSON) {
        self.id = obj["id"].intValue
        self.firstName = obj["first_name"].stringValue
        self.LastName = obj["last_name"].stringValue
        self.imgURL = obj["img_Url"].stringValue

    }
    
}
