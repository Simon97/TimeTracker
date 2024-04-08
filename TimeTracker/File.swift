//
//  File.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 05/04/2024.
//

import Foundation
import Observation

@Observable
class TimeRegistrationsList {
    var timeRegistrations: [TimeRegistration]
    
    init(timeRegistrations: [TimeRegistration]) {
        self.timeRegistrations = timeRegistrations
    }
    
    func append(_ timeRegistration: TimeRegistration) {
        self.timeRegistrations.append(timeRegistration)
    }
}
