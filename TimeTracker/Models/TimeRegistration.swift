//
//  TimeRegistration.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 14/01/2024.
//

import Foundation
import SwiftData

@Model
class TimeRegistration {
    var startTime: Date
    var endTime: Date?
    
    var activity: Activity
    
    init(startTime: Date, activity: Activity) {
        self.startTime = startTime
        self.activity = activity
    }
}
