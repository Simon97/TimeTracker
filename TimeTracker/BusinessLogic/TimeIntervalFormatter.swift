//
//  TimeIntervalFormatter.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 28/05/2024.
//

import Foundation


/**
 * This is used to format a TimeInterval to look like the SwiftUI timer-style.
 * It is needed since we want to show the time as the timer style, but paused.
 
 * It should be possible to do it with SDK functions (I think), but now when the function
 * is encapsulated here, it can always be changed.
 
 * Note that a TimeInterval is just a typealias for Double (in Swift).
 */

class TimeIntervalFormatter {
    
    func format(timeInterval: TimeInterval) -> String {
        let values = computeValues(timeInterval: timeInterval)
        
        let hoursString = String(values.hours)
        let minutesString = formatAmount(amount: values.minutes, hasParent: values.hours > 0)
        let secondsString = formatAmount(amount: values.seconds, hasParent: true)
        
        if values.hours > 0 {
            return "\(hoursString).\(minutesString).\(secondsString)"
        } else {
            return "\(minutesString).\(secondsString)"
        }
    }
    
    private func formatAmount(amount: Int, hasParent: Bool) -> String {
        if amount > 9 || !hasParent {
            return String(amount)
        } else {
            return "0\(amount)"
        }
    }
    
    private func computeValues(timeInterval: TimeInterval) -> HoursMinutesSeconds {
        // Doing it without the SDK for now
        
        let secondsForHour = 3600
        let secondsForMinute = 60
        
        var remainingAmountOfSeconds = Int(timeInterval)
        if remainingAmountOfSeconds == 0 {
            return .zero
        }
        
        let amountOfHours: Int = remainingAmountOfSeconds / secondsForHour
        remainingAmountOfSeconds = remainingAmountOfSeconds % secondsForHour
        
        let amountOfMinutes: Int = remainingAmountOfSeconds / secondsForMinute
        remainingAmountOfSeconds = remainingAmountOfSeconds % secondsForMinute
        
        let amountOfSeconds: Int = remainingAmountOfSeconds
        
        return HoursMinutesSeconds(
            hours: amountOfHours,
            minutes: amountOfMinutes,
            seconds: amountOfSeconds
        )
    }
    
}

struct HoursMinutesSeconds {
    var hours: Int
    var minutes: Int
    var seconds: Int
    
    static var zero = HoursMinutesSeconds(hours: 0, minutes: 0, seconds: 0)
}
