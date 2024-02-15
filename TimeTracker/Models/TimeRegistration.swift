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
    var endTime: Date
    
    var task: Task
    
    init(startTime: Date, endTime: Date, task: Task) {
        self.startTime = startTime
        self.endTime = endTime
        self.task = task
    }
}
