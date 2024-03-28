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
    
    func currentTimeRegistration(_ timeRegistrations: inout [TimeRegistration]) -> TimeRegistration? {
        sortByDate(&timeRegistrations)
        return timeRegistrations.first
    }
    
    func currentTask(_ timeRegistrations: inout [TimeRegistration]) -> Task? {
        currentTimeRegistration(&timeRegistrations)?.task
    }
    
    func currentProject(_ timeRegistrations: inout [TimeRegistration]) -> ProjectWithTasks? {
        currentTimeRegistration(&timeRegistrations)?.task.project
    }
    
    /**
     Returns number of seconds spend on the task the given date
     */
    func timeSpendOnTaskonDate(_ timeRegistrations: [TimeRegistration], task: Task, date: Date) -> TimeInterval {
        let registrationsForTaskOnDate = timeRegistrationsForDay(timeRegistrations: task.timeRegistrations, date: date)
    
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
    
    private func timeRegistrationsForTask(timeRegistrations: [TimeRegistration], task: Task) -> [TimeRegistration] {
        let timeRegistrationsForGivenTask = timeRegistrations.filter({ r in
            r.task === task
        })
        return timeRegistrationsForGivenTask
    }
    
    
}
