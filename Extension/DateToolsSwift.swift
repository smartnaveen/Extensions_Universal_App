//
//  DateToolsSwift.swift
//  Extension
//
//  Created by Naveen Kumar on 06/07/21.
//

import Foundation
import UIKit

/*
 # 13-digit TimeStamp
 
 let timeResult = objRating.data[indexPath.row].timestamp / 1000
 let date = Date(timeIntervalSince1970: timeResult)
 
 let dateFormatter = DateFormatter()
 dateFormatter.dateFormat = "dd"
 let nameOfDate = dateFormatter.string(from: date)
 
 dateFormatter.dateFormat = "MMMM"
 let nameOfMonth = dateFormatter.string(from: date)
 
 dateFormatter.dateFormat = "yyyy"
 let nameOfYear = dateFormatter.string(from: date)
 
 dateFormatter.dateFormat = "EEEE"
 let nameOfWeek = dateFormatter.string(from: date)

 
 cell.textLabel?.text = "\("\(nameOfDate) " + "\(nameOfMonth) " + "\(nameOfYear)")"  //3 july 2021
 */


import DateToolsSwift
// MARK: - Using 3rd-party DateToolsSwift
/*
 let timeResult = i.timestamp / 1000
 let date = Date(timeIntervalSince1970: timeResult)
 
 if date.isToday {
     
 }else if date.isYesterday {
     
 }else if date.isTomorrow {
     
 }else if date.isWeekend {
     
 }else if date.timeAgoSinceNow{
 // 4 months ago

}
 */


extension Date {
    func timeAgoDisplay() -> String {
        let calendar = Calendar.current
        let minuteAgo = calendar.date(byAdding: .minute, value: -1, to: Date())!
        let hourAgo = calendar.date(byAdding: .hour, value: -1, to: Date())!
        let dayAgo = calendar.date(byAdding: .day, value: -1, to: Date())!
        let weekAgo = calendar.date(byAdding: .day, value: -7, to: Date())!
        let monthAgo = calendar.date(byAdding: .month, value: -12, to: Date())!
        let yearAgo = calendar.date(byAdding: .year, value: -12, to: Date())!

        if minuteAgo < self {
            let diff = Calendar.current.dateComponents([.second], from: self, to: Date()).second ?? 0
            return "\(diff) sec ago"
        } else if hourAgo < self {
            let diff = Calendar.current.dateComponents([.minute], from: self, to: Date()).minute ?? 0
            return "\(diff) min ago"
        } else if dayAgo < self {
            let diff = Calendar.current.dateComponents([.hour], from: self, to: Date()).hour ?? 0
            return "\(diff) hrs ago"
        } else if weekAgo < self {
            let diff = Calendar.current.dateComponents([.day], from: self, to: Date()).day ?? 0
            return "\(diff) days ago"
        }else if monthAgo < self {
            let diff = Calendar.current.dateComponents([.month], from: self, to: Date()).month ?? 0
            return "\(diff) months ago"
        }else if yearAgo < self {
            let diff = Calendar.current.dateComponents([.year], from: self, to: Date()).year ?? 0
            if diff == 1 {
                return "\(diff) year ago" // an year ago
            }else{
                return "\(diff) year ago"
            }
        }
        return ""
    }
}

/*
 let now = Date()
 let time = now.timeAgoDisplay()
 print(time)
 */
