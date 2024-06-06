//
//  TimeRegistrationChecker.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 09/05/2024.
//

import Foundation
import SwiftData // This is needed to operate on ModelContext (to automatically fix some of the issues for the user) (WIP)

/**
 * For some reason, there are problems when the @Model SwifData attribute is used for temporary objects.
 * It crashes when some of the properties are called. Therefore, we have this struct which is the same as TimeRegistraion, except
 * that it is not a SwiftData @Model (and it is a value type as well).
 */
struct TimeRegistrationCheckerInput {
    var uuid: UUID
    var startTime: Date
    var endTime: Date?
    var activity: Activity?
    
    init(timeRegistration: TimeRegistration) {
        self.uuid = timeRegistration.uuid
        self.activity = timeRegistration.activity
        self.startTime = timeRegistration.startTime
        self.endTime = timeRegistration.endTime
    }
    
    init(startTime: Date, activity: Activity?) {
        self.uuid = UUID()
        self.startTime = startTime
        self.activity = activity
    }
    
    init(startTime: Date, endTime: Date, activity: Activity?) {
        self.uuid = UUID()
        self.startTime = startTime
        self.endTime = endTime
        self.activity = activity
    }
}

struct TimeRegistrationCheckerResponse {
    var hasError: Bool
    var errorMessage: String?
    
    init(hasError: Bool, errorMessage: String? = nil) {
        self.hasError = hasError
        self.errorMessage = errorMessage
    }
    
    // If there is an errormessage, there is of course also an error
    init(errorMessage: String? = nil) {
        self.hasError = true
        self.errorMessage = errorMessage
    }
    
    static var good = TimeRegistrationCheckerResponse(hasError: false)
}

class TimeRegistrationChecker {
    
    /**
     * This checks that a single time registration is in the right shape and form
     * without comparing it with other registrations
     */
    func check(timeRegistration: TimeRegistrationCheckerInput) -> [TimeRegistrationCheckerResponse] {
        var results = [TimeRegistrationCheckerResponse]()
        
        results.append(checkStartBeforeEnd(timeRegistration: timeRegistration))
        results.append(checkThatAnActivityIsSelected(timeRegistration: timeRegistration))
        
        return results
    }
    
    func checkStartBeforeEnd(timeRegistration: TimeRegistrationCheckerInput) -> TimeRegistrationCheckerResponse {
        
        if timeRegistration.endTime == nil {
            return .good
            
        } else if isStartBeforeEnd(startDate: timeRegistration.startTime, endDate: timeRegistration.endTime!) {
            return .good
            
        } else {
            return TimeRegistrationCheckerResponse(
                hasError: true,
                errorMessage: "The start time must be before the end time!"
            )
        }
    }
    
    func checkThatAnActivityIsSelected(timeRegistration: TimeRegistrationCheckerInput) -> TimeRegistrationCheckerResponse {
        if timeRegistration.activity != nil {
            return .good
        } else {
            return TimeRegistrationCheckerResponse(
                errorMessage: "Please select an activity. If none exists, they can be created at the Activity tab"
            )
        }
    }
    
    
    private func isStartBeforeEnd(startDate: Date, endDate: Date) -> Bool {
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
    
    var suggestedAction: SuggestedAction?
    
    init(isGood: Bool, errorMessage: String? = nil, suggestedAction: SuggestedAction? = nil) {
        self.isGood = isGood
        self.errorMessage = errorMessage
        self.suggestedAction = suggestedAction
    }
    
    static var good = TimeRegistrationCheckerResponse(hasError: false)
}


/**
 * This is very much a work in progress still.
 * It should at some point be able to check if all the registrations together makes sense.
 * For example, that none of them overlaps and so on
 */
class TimeRegistrationSetChecker {
    
    /**
     This checks a that a collection of time registrations is in the right shape and form
     */
    static func check(timeRegistrations: [TimeRegistration]) -> [TimeRegistrationSetCheckerResponse] {
        let results = [TimeRegistrationSetCheckerResponse]() // Made a let, since the linter complains about newer modified
        
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
