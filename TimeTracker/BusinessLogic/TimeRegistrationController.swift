//
//  TimeRegistrationController.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 17/02/2024.
//

import Foundation
import SwiftData

class TimeRegistrationController {
    
    func addTimeRegistration(
        _ registration: TimeRegistration,
        timeRegistrations: [TimeRegistration],
        modelContext: ModelContext) {
        let now = Date.now
        // Before adding a registration, we must make sure to end the ongoing one, if it isen't already
        endCurrentRegistrationIfNotEnded(
            endTime: now,
            timeRegistrations: timeRegistrations
        )
        modelContext.insert(registration)
    }
    
    func endCurrentRegistrationIfNotEnded(
        endTime: Date,
        timeRegistrations: [TimeRegistration]) {
            let newestReg = findLastAddedRegistration(timeRegistrations)
            newestReg?.endTime = .now
        }
    
    // TODO: Make sure registrations made across different days are added as multiple registrations such that no registration starts and ends at different days.
    func pauseTracking(timeRegistrations: [TimeRegistration]) {
        let newestReg = findLastAddedRegistration(timeRegistrations)
        newestReg?.endTime = .now
    }
    
    func resumeTracking(timeRegistrations: [TimeRegistration], modelContext: ModelContext) {
        let newestReg = findLastAddedRegistration(timeRegistrations)
        
        if let latestTrackedActivity = newestReg?.activity {
            let newRegistration = TimeRegistration(
                startTime: .now,
                activity: latestTrackedActivity
            )
            modelContext.insert(newRegistration)
        }
    }
    
    func isRegistrationOnGoing(timeRegistrations: [TimeRegistration]) -> Bool {
        if timeRegistrations.isEmpty {
            return false
        }
        return findLastAddedRegistration(timeRegistrations)?.endTime == nil
    }
    
    /**
     * Finds the last added registration, which can either be a:
     * Completed registration with an endTime, meaning that there are no ongoing tracking.
     * A non-completed registration meaning that there is an ongoing tracking running.
     * nil, if the given registration-list is empty
     */
    func findLastAddedRegistration(_ timeRegistrations: [TimeRegistration]) -> TimeRegistration? {
        var copy = timeRegistrations
        sortByDate(&copy)
        return copy.first
    }
    
    func currentActivity(_ timeRegistrations: [TimeRegistration]) -> Activity? {
        if let latestRegistration = findLastAddedRegistration(timeRegistrations) {
            if latestRegistration.endTime == nil {
                return latestRegistration.activity
            }
        }
        return nil
    }
    
    func isActivityOngoing(_ activity: Activity, timeRegistrations: [TimeRegistration]) -> Bool {
        activity == currentActivity(timeRegistrations)
    }
    
    func totalTimeForRegistrations(timeRegistrations: [TimeRegistration]) -> TimeInterval {
        var interval: TimeInterval = 0.0
        for registration in timeRegistrations {
            interval += secondsBetweenDates(date1: registration.startTime, date2: registration.endTime ?? .now)
        }
        return interval
    }
    
    func timeSpendOnCurrentActivityOnDate(timeRegistrations: [TimeRegistration], date: Date) -> TimeInterval {
        let onGoingTimeRegistration = findLastAddedRegistration(timeRegistrations)
        let onGoingActivity: Activity? = onGoingTimeRegistration?.activity
        if onGoingActivity == nil {
            return 0.0
        } else {
            return timeSpendOnActivityonDate(timeRegistrations, activity: onGoingActivity!, date: date)
        }
    }
    
    /**
     Returns the number of seconds spend on the given activity on the given date
     Note: This does *currently* not support if a registration starts and stops at different days. (TODO in pauseTracking)
     */
    func timeSpendOnActivityonDate(_ timeRegistrations: [TimeRegistration], activity: Activity, date: Date) -> TimeInterval {
        let registrationsForTaskOnDate = timeRegistrationsForDay(timeRegistrations: activity.timeRegistrations, date: date)
        
        var amountOfSecondsSpend = 0.0
        for registration in registrationsForTaskOnDate {
            let timeSpend = secondsBetweenDates(
                date1: registration.startTime,
                date2: registration.endTime ?? .now // if the endTime is still nil, it is the ongoing registration
            )
            amountOfSecondsSpend += timeSpend
        }
        return amountOfSecondsSpend
    }
    
    private func sortByDate(_ timeRegistrations: inout [TimeRegistration]) {
        timeRegistrations.sort(by: { r1, r2 in
            r1.startTime.compare(r2.startTime) == .orderedDescending
        })
    }
    
    private func secondsBetweenDates(date1: Date, date2: Date) -> TimeInterval {
        let seconds = date2.timeIntervalSince(date1)
        return seconds
    }
    
    private func timeRegistrationsForDay(timeRegistrations: [TimeRegistration], date: Date) -> [TimeRegistration] {
        let timeRegistrationsForGivenDay = timeRegistrations.filter({ r in
            sameDay(first: date, second: r.startTime)
        })
        return timeRegistrationsForGivenDay
    }
    
    private func sameDay(first: Date, second: Date) -> Bool {
        Calendar.current.isDate(first, equalTo: second, toGranularity: .day)
    }
}
