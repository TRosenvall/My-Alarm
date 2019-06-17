//
//  Alarm.swift
//  My Alarm
//
//  Created by Timothy Rosenvall on 6/17/19.
//  Copyright © 2019 Timothy Rosenvall. All rights reserved.
//

import Foundation

class Alarm {
    
    var fireDate = Date()
    var name: String
    var enabled: Bool
    var uuid: String
    var fireTimeAsString: String {
        get{
            return DateFormatter().string(from: fireDate)
        }
    }
    
    init(name: String, enabled: Bool, uuid: String) {
        self.name = name
        self.enabled = enabled
        self.uuid = uuid
    }
    
}
