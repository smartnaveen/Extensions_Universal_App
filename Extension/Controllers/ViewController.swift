


import UIKit
import FSCalendar

class ViewController: UIViewController {
    
    @IBOutlet weak var fsCalendar: FSCalendar!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)        
    }
  
}
    

// MARK: - Extension
extension ViewController: FSCalendarDataSource, FSCalendarDelegate {
 
    //Set Minimum Date
    func minimumDate(for calendar: FSCalendar) -> Date {
           return Date()
    }
     
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
             print(date)
    }
}
