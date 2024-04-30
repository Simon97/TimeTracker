//
//  TimeRegistrationController.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 17/02/2024.
//

import Foundation

class TimeRegistrationController {
    
    func sortByDate(_ timeRegistrations: inout [TimeRegistration]) {
        timeRegistrations.sort(by: { r1, r2 in
            r1.startTime.compare(r2.startTime) == .orderedDescending
        })
    }
    
    /**
     Returns nil, if the given TimeRegistration array is empty
     */
    func newestTimeRegistrationInList(_ timeRegistrations: [TimeRegistration]) -> TimeRegistration? {
        var copy = timeRegistrations
        sortByDate(&copy)
        return copy.first
    }
    
    func currentActivity(_ timeRegistrations: [TimeRegistration]) -> Activity? {
        newestTimeRegistrationInList(timeRegistrations)?.activity
    }
    
    /**
     Returns number of seconds spend on the task the given date
     */
    func timeSpendOnTaskonDate(_ timeRegistrations: [TimeRegistration], activity: Activity, date: Date) -> TimeInterval {
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
    
    private func timeRegistrationsForTask(timeRegistrations: [TimeRegistration], activity: Activity) -> [TimeRegistration] {
        let timeRegistrationsForGivenTask = timeRegistrations.filter({ r in
            r.activity === activity
        })
        return timeRegistrationsForGivenTask
    }
}
