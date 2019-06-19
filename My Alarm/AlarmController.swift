//
//  AlarmController.swift
//  My Alarm
//
//  Created by Timothy Rosenvall on 6/17/19.
//  Copyright © 2019 Timothy Rosenvall. All rights reserved.
//

import Foundation
import UserNotifications

protocol AlarmScheduler: class {
    func scheduleUserNotifications(alarm: Alarm)
    func cancelUserNotifications(alarm: Alarm)
}

extension AlarmScheduler {
    func scheduleUserNotifications(alarm: Alarm) {
        let mutable = UNMutableNotificationContent()
        mutable.title = "This is the title"
        mutable.body = "This is the body"
        mutable.sound = .default

        let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: alarm.fireDate)
        let calendar = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: alarm.uuid, content: mutable, trigger: calendar)
        UNUserNotificationCenter.current().add(request)
    }
    
    func cancelUserNotifications(alarm: Alarm) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [alarm.uuid])
    }
}

class AlarmController: AlarmScheduler {
    
    static let sharedInstance = AlarmController()
    
    var alarms: [Alarm] = []
    var mockAlarms: [Alarm] {
        let alarm1: Alarm = Alarm(fireDate: Date(), name: "Alarm1")
        let alarm2: Alarm = Alarm(fireDate: Date(), name: "Alarm2")
        let alarm3: Alarm = Alarm(fireDate: Date(), name: "Alarm3")
        let alarm4: Alarm = Alarm(fireDate: Date(), name: "Alarm4")
        return [alarm1, alarm2, alarm3, alarm4]
    }
    
    init () {
        loadFromPersistentStore()
    }
    
    func addAlarm(fireDate: Date, name: String, enabled: Bool) {
        let alarm = Alarm(fireDate: fireDate, name: name, enabled: enabled)
        alarms.append(alarm)
        if alarm.enabled {
            scheduleUserNotifications(alarm: alarm)
        } else {
            cancelUserNotifications(alarm: alarm)
        }
        saveToPersistentStore()
    }
    
    func fileURL() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = paths[0]
        let fileName = "Alarms.json"
        let url = documentDirectory.appendingPathComponent(fileName)
        return url
    }
    
    func saveToPersistentStore() {
        let jsonEncoder = JSONEncoder()
        
        do {
            let data = try jsonEncoder.encode(alarms)
            try data.write(to: fileURL())
        } catch let error {
            print("Error saving to persistent store: \(error.localizedDescription)")
        }
    }
    
    func loadFromPersistentStore() {
        let jsonDecoder = JSONDecoder()
        do {
            let jsonData = try Data(contentsOf: fileURL())
            let decodedAlarms = try jsonDecoder.decode([Alarm].self, from: jsonData)
            alarms = decodedAlarms
        } catch let error {
            print("Error loading from persistent store: \(error.localizedDescription)")
        }
    }
    
    func updateAlarm(alarm: Alarm, fireDate: Date, name: String, enabled: Bool) {
        alarm.fireDate = fireDate
        alarm.name = name
        alarm.enabled = enabled
        if alarm.enabled {
            scheduleUserNotifications(alarm: alarm)
        } else {
            cancelUserNotifications(alarm: alarm)
        }
        saveToPersistentStore()
    }
    
    func toggleIsOn( for alarm: Alarm ) {
        alarm.enabled = !alarm.enabled
        if alarm.enabled {
            scheduleUserNotifications(alarm: alarm)
        } else {
            cancelUserNotifications(alarm: alarm)
        }
        saveToPersistentStore()
    }
    
    func deleteAlarm(alarm: Alarm) {
        guard let index = alarms.firstIndex(of: alarm) else {return}
        alarms.remove(at: index)
        cancelUserNotifications(alarm: alarm)
        saveToPersistentStore()
    }
}
