//
//  TimeRegistrationChecker.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 09/05/2024.
//

import Foundation

struct TimeRegistrationCheckerResponse {
    var isGood: Bool
    var errorMessage: String?
    
    init(isGood: Bool, errorMessage: String? = nil) {
        self.isGood = isGood
        self.errorMessage = errorMessage
    }
    
    static var good = TimeRegistrationCheckerResponse(isGood: true)
}

class TimeRegistrationChecker {
    
    /**
     This checks a that a single time registration is in the right shape and form
     */
    static func check(timeRegistration: TimeRegistration) -> [TimeRegistrationCheckerResponse] {
        var results = [TimeRegistrationCheckerResponse]()
        
        results.append(checkStartBeforeEnd(timeRegistration: timeRegistration))
        // Add more checks ...
        
        return results
    }
    
    static func checkStartBeforeEnd(timeRegistration: TimeRegistration) -> TimeRegistrationCheckerResponse {
        
        if timeRegistration.endTime == nil {
            return .good
            
        } else if isStartBeforeEnd(startDate: timeRegistration.startTime, endDate: timeRegistration.endTime!) {
            return TimeRegistrationCheckerResponse(isGood: true)
            
        } else {
            return TimeRegistrationCheckerResponse(
                isGood: false,
                errorMessage: "The start time must be before the end time!"
            )
        }
    }
    
    private static func isStartBeforeEnd(startDate: Date, endDate: Date) -> Bool {
        return startDate < endDate
    }
    
}

