
import Foundation
import EventKit
import UIKit

class EventHelper{
    static var shared = EventHelper()
    
    let appleEventStore = EKEventStore()
    var calendars: [EKCalendar]?
    
    func generateEvent() {
        let status = EKEventStore.authorizationStatus(for: EKEntityType.event)
        switch (status){
        case EKAuthorizationStatus.notDetermined:
            requestAccessToCalendar()
        case EKAuthorizationStatus.authorized:
            print("User has access to calendar")
            self.addAppleEvents()
        case EKAuthorizationStatus.restricted, EKAuthorizationStatus.denied:
            noPermission()
         default:
            break
        }
    }
    
    func noPermission(){
        print("User has to change settings...goto settings to view access")
    }
  
    func requestAccessToCalendar() {
        appleEventStore.requestAccess(to: .event, completion: { (granted, error) in
            if (granted) && (error == nil) {
                DispatchQueue.main.async {
                    print("User has access to calendar")
                    self.addAppleEvents()
                }
            } else {
                DispatchQueue.main.async{
                    self.noPermission()
                }
            }
        })
    }
    
    func addAppleEvents(){
        let event:EKEvent = EKEvent(eventStore: appleEventStore)
        event.title = "Test Event"
        event.startDate = NSDate() as Date
        event.endDate = NSDate() as Date
        event.notes = "This is a note"
        event.calendar = appleEventStore.defaultCalendarForNewEvents
        do {
            try appleEventStore.save(event, span: .thisEvent)
            print("events added with dates:")
        } catch let e as NSError {
            print(e.description)
            return
        }
        print("Saved Event")
    }
}

// how to use
override func viewDidLoad() {
        super.viewDidLoad()
        EventHelper.shared.generateEvent()
    }
// add key in plist 
Privacy - Calendars Usage Description = "$(PRODUCT_NAME) calendar events"
