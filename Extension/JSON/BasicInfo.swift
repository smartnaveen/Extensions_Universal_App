//
//  BasicInfo.swift
//  dem
//
//  Created by Naveen Kumar on 31/07/22.
//

import Foundation
import UIKit

struct BasicInfo: Codable {
    var name: String = ""
    var age: Int = 0
    var ethic: [String] = []
    var ethic1: [String] = []

    
    func toJSON() -> [String: Any] {
        let json: [String: Any] = [
            "name": name,
            "age": age,
            "ethic": [ethic],
            "ethic1": [ethic1]
        ]
        return json
    }
}

class BasicInfoData: Codable {
    static let shared = BasicInfoData()

    func getData() -> BasicInfo {
        let data: BasicInfo = BasicInfo(name: "Naveen", age: 21, ethic: ["a","b","c"], ethic1: ["a","b","c"])
        return data
    }
}
