//
//  Alarm.swift
//  My Alarm
//
//  Created by Timothy Rosenvall on 6/17/19.
//  Copyright © 2019 Timothy Rosenvall. All rights reserved.
//

import Foundation

class Alarm {
    
    var fireDate: Date
    var name: String
    var enabled: Bool
    var uuid: String
    var fireTimeAsString: String {
        get{
            return DateFormatter().string(from: fireDate)
        }
    }
    
    init(fireDate: Date, name: String, enabled: Bool, uuid: String) {
        self.fireDate = fireDate
        self.name = name
        self.enabled = enabled
        self.uuid = uuid
    }
}

extension Alarm: Equatable {
    static func == (lhs: Alarm, rhs: Alarm) -> Bool {
        return lhs.fireDate == rhs.fireDate && lhs.name == rhs.name && lhs.enabled == rhs.enabled && lhs.uuid == rhs.uuid
    }
    
    
}
