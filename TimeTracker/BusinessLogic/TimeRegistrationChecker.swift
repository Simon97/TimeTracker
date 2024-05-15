//
//  TimeRegistrationChecker.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 09/05/2024.
//

import Foundation
import SwiftData // This is needed to operate on ModelContext (to automatically fix some of the issues for the user)

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

struct SuggestedAction {
    var description: String
    var action: (ModelContext) -> Void
}

struct TimeRegistrationSetCheckerResponse {
    var isGood: Bool
    var errorMessage: String?
    
    // For now, I think we should just tell the user about the issues since a lot of things can go wrong
    // if we try to fix some of it...
    var suggestedAction: SuggestedAction?
    
    init(isGood: Bool, errorMessage: String? = nil, suggestedAction: SuggestedAction? = nil) {
        self.isGood = isGood
        self.errorMessage = errorMessage
        self.suggestedAction = suggestedAction
    }
    
    static var good = TimeRegistrationCheckerResponse(isGood: true)
}

class TimeRegistrationSetChecker {
    
    /**
     This checks a that a collection of time registrations is in the right shape and form
     */
    static func check(timeRegistrations: [TimeRegistration]) -> [TimeRegistrationSetCheckerResponse] {
        var results = [TimeRegistrationSetCheckerResponse]()
        
        // results.append(checkStartBeforeEnd(timeRegistration: timeRegistration))
        // Add more checks ...
        
        return results
    }
    
    static func checkIfRegistrationOverlapsWithTheRegistrationBefore(
        timeRegistration: TimeRegistration,
        timeRegistrations: [TimeRegistration]) -> TimeRegistrationSetCheckerResponse {
            
          return TimeRegistrationSetCheckerResponse(isGood: false, errorMessage: "You have a problem!", suggestedAction: SuggestedAction(description: "Wanna fix it?", action: { modelContext in
          }))
            
        }
    
    // static func checkIfRegistrationOverlapsWithTheRegistrationAfter(timeRegistration: TimeRegistration, timeRegistrations: [TimeRegistration]) -> TimeRegistrationSetCheckerResponse {}
    
}
