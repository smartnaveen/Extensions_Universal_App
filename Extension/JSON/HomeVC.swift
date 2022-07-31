//
//  ViewController.swift
//  dem
//
//  Created by Naveen Kumar on 27/06/22.
//

import UIKit
import SwiftyJSON

class HomeVC: UIViewController {
        
    let userDefaults = UserDefaults.standard
    var arrQuestionModel: [QuestionModel] = []
    var basicInfo = BasicInfo()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arrQuestionModel = ModelData.shared.getData()
        basicInfo = BasicInfoData.shared.getData()
        let json = basicInfo.toJSON()
        print(json)
    }
    
    @IBAction func btnFinish(_ sender: UIButton) {
        var json: [[String:Any]] = []
        
        for obj in arrQuestionModel {
            print(obj)
            json.append(obj.toJSON())
        }
        print(json)
    }
    
}

