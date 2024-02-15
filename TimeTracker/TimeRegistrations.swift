//
//  TimeRegistrations.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 14/02/2024.
//

import Foundation
import SwiftData

@Observable
class TimeRegistrations {
    var timeRegistrations: [TimeRegistration]
    
    init(timeRegistrations: [TimeRegistration]) {
        self.timeRegistrations = timeRegistrations
    }
}
