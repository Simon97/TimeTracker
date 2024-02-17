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
        timeRegistrations.sort(by: { r1, r2 in
            r1.startTime.compare(r2.startTime) == .orderedDescending
        })
    }
    
}
