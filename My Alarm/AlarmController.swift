//
//  AlarmController.swift
//  My Alarm
//
//  Created by Timothy Rosenvall on 6/17/19.
//  Copyright © 2019 Timothy Rosenvall. All rights reserved.
//

import Foundation

class AlarmController {
    
    static let sharedInstance = AlarmController()
    
    let mockAlarms: [Alarm]
//    var alarms: [Alarm] = []
    var alarms: [Alarm] = mockAlarms    // Sets the alarms to our mock alarm data for testing
    
    init() {
        let alarm1: Alarm = Alarm(fireDate: Date(), name: "Alarm1", enabled: true, uuid: "this is a uuid")
        let alarm2: Alarm = Alarm(fireDate: Date(), name: "Alarm2", enabled: false, uuid: "this is another uuid")
        let alarm3: Alarm = Alarm(fireDate: Date(), name: "Alarm3", enabled: true, uuid: "this is yet another uuid")
        let alarm4: Alarm = Alarm(fireDate: Date(), name: "Alarm4", enabled: false, uuid: "this is the final uuid")
        self.mockAlarms = [alarm1, alarm2, alarm3, alarm4]
    }
    
    
    
    func addAlarm(fireDate: Date, name: String, enabled: Bool) -> Alarm {
        let alarm = Alarm(fireDate: fireDate, name: name, enabled: enabled, uuid: "To be used")
        alarms.append(alarm)
        return alarm
    }
    
    func updateAlarm(alarm: Alarm, fireDate: Date, name: String, enabled: Bool) {
        alarm.fireDate = fireDate
        alarm.name = name
        alarm.enabled = enabled
    }
    
    func deleteAlarm(alarm: Alarm) {
        guard let index = alarms.firstIndex(of: alarm) else {return}
        alarms.remove(at: index)
    }
}
