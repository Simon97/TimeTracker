//
//  TimeRegistrationChecker.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 09/05/2024.
//

import Foundation
import SwiftData

/**
 * For some reason, using the @Model SwifData attribute for temporary objects causes
 * problems, leading to crashes when certain properties are accessed. Therefore, we
 * have created this struct, which is similar to the TimeRegistration class but does
 * not use the SwiftData @Model attribute.
 */
struct TimeRegistrationCheckerInput {
    var startTime: Date
    var endTime: Date?
    var activity: Activity?
    
    init(timeRegistration: TimeRegistration) {
        self.activity = timeRegistration.activity
        self.startTime = timeRegistration.startTime
        self.endTime = timeRegistration.endTime
    }
    
    init(startTime: Date, endTime: Date?, activity: Activity?) {
        self.startTime = startTime
        self.endTime = endTime
        self.activity = activity
    }
}

struct TimeRegistrationCheckerResponse {
    var hasError: Bool
    var errorMessage: String?
    
    init(errorMessage: String) {
        self.hasError = true
        self.errorMessage = errorMessage
    }
    
    static var good = TimeRegistrationCheckerResponse(hasError: false)
    
    private init(hasError: Bool, errorMessage: String? = nil) {
        self.hasError = hasError
        self.errorMessage = errorMessage
    }
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
        guard let endTime = timeRegistration.endTime else {
            return .good
        }
        if isStartBeforeEnd(startDate: timeRegistration.startTime, endDate: endTime) {
            return .good
        } else {
            return TimeRegistrationCheckerResponse(
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
    var hasError: Bool
    var errorMessage: String?
    
    var suggestedAction: SuggestedAction?
    
    init(hasError: Bool, errorMessage: String? = nil, suggestedAction: SuggestedAction? = nil) {
        self.hasError = hasError
        self.errorMessage = errorMessage
        self.suggestedAction = suggestedAction
    }
    
    static var good = TimeRegistrationSetCheckerResponse(hasError: false)
}


/**
 * This is very much a work in progress still. (And currently not in use)
 * It should at some point be able to check if all the registrations together makes sense.
 * For example, that none of them overlaps and so on
 */
class TimeRegistrationSetChecker {
    
    /**
     This checks a that a collection of time registrations is in the right shape and form
     */
    static func check(timeRegistrations: [TimeRegistration]) -> [TimeRegistrationSetCheckerResponse] {
        let results = [TimeRegistrationSetCheckerResponse]()
        
        // Checks ...
        
        return results
    }
    
    static func checkIfRegistrationOverlapsWithTheRegistrationBefore(
        timeRegistration: TimeRegistration,
        timeRegistrations: [TimeRegistration]) -> TimeRegistrationSetCheckerResponse {
            return TimeRegistrationSetCheckerResponse(hasError: false, errorMessage: "You have a problem!", suggestedAction: SuggestedAction(description: "Wanna fix it?", action: { modelContext in
            }))
        }
}

