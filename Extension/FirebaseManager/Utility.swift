//
//  Utility.swift
//  Firestore Demo
//
//  Created by Naveen Kumar on 18/10/21.
//

import Foundation
import UIKit

class Utility: NSObject {
    static let shared = Utility()
    
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
