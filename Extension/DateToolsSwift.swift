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


// Most Useful converter to string to date
func convertDateFormat(inputDate: String) -> String {
    let olDateFormatter = DateFormatter()
    olDateFormatter.locale = Locale(identifier: "en_US_POSIX")
    olDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    let oldDate = olDateFormatter.date(from: inputDate)
    let convertDateFormatter = DateFormatter()
    convertDateFormatter.dateFormat = "MMM dd yyyy h:mm a"
    return convertDateFormatter.string(from: oldDate!)
}
let dateString = "2021-06-07T18:23:05.000Z"
let t = convertDateFormat(inputDate: dateString)
//print(t)







// MARK: - Current/selected Time lie between open-closed.

/*
 
override func viewDidLoad() {
    super.viewDidLoad()
    
    
    let calendar = Calendar.current
    let now = Date()

    // MARK: - Selected Time
    let selectedTime = calendar.date(
        bySettingHour: 16,
        minute: 30,
        second: 0,
        of: now)!
    

    // MARK: - Starting Time
    let eight_today = calendar.date( // 30 min  add
      bySettingHour: 6,
      minute: 0,
      second: 0,
      of: now)!
    
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm"
    let thirtyMinLater = Calendar.current.date(byAdding: .minute, value: 30, to: eight_today)!
    let timeCalcualted = formatter.string(from: thirtyMinLater)
    print(timeCalcualted)

    
    let hour = calendar.component(.hour, from: thirtyMinLater)
    let min = calendar.component(.minute, from: thirtyMinLater)
    print(hour,min)
    
    let finalTimeLater30min = calendar.date(
        bySettingHour: hour,
        minute: min,
        second: 0,
        of: thirtyMinLater)!
    

    // MARK: - Closed timing
    let four_thirty_today = calendar.date( // 45 min subtract
      bySettingHour: 17,
      minute: 30,
      second: 0,
      of: now)!
    
    let fourty45Before = Calendar.current.date(byAdding: .minute, value: -45, to: four_thirty_today)!
    let timeCalcualteded = formatter.string(from: fourty45Before)
    print(timeCalcualteded)

    
    let hour1 = calendar.component(.hour, from: fourty45Before)
    let min1 = calendar.component(.minute, from: fourty45Before)
    print(hour1,min1)

    
    let finalTimeBefore45min = calendar.date(
        bySettingHour: hour1,
        minute: min1,
        second: 0,
        of: fourty45Before)!
    
   

    if selectedTime >= finalTimeLater30min &&
        selectedTime <= finalTimeBefore45min {
      print("The time is between 8:00 and 16:30")
    }else {
        print("Not exists")
    }
    
}
 
 */


