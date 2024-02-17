//
//  TimeRegistrationController.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 17/02/2024.
//

import Foundation

// TODO: Consider moving this class to an extension to TimeRegistrationViewModel

class TimeRegistrationController {
    
    func sortByDate(_ timeRegistrations: inout [TimeRegistration]) {
        timeRegistrations.sort(by: { a, b in
            a.startTime.compare(b.startTime) == .orderedDescending
        })
    }
    
}
