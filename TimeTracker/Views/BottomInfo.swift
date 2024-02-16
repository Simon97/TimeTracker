//
//  BottomInfo.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 16/01/2024.
//

import SwiftUI

struct BottomInfo: View {
    
    var timeRegistrations: [TimeRegistration]
    
    var currentTask: Task {
        var registrationsCopy = timeRegistrations
        print(registrationsCopy.count)
        
        registrationsCopy.sort(by: { a, b in
            a.startTime.compare(b.startTime) == .orderedDescending
        })
        let returnTask = registrationsCopy.first?.task ?? .noTask()
        print(returnTask.name)
        return returnTask
    }
    
    var currentProject: Project {
        return currentTask.project ?? Project("", isMainProject: false, isCollapsed: false)
    }
    
    // TODO: These should be used to show timer value
    let secondsSpendTotalToday: Int
    let secondsSpendOnCurrentProjectTotalToday: Int
    
    var timeUsedOnProject: Date {
        getStartDateForTimer(amountOfSeconds: secondsSpendOnCurrentProjectTotalToday)
    }
    
    var timeUsedToday: Date {
        getStartDateForTimer(amountOfSeconds: secondsSpendTotalToday)
    }
    
    var body: some View {
        VStack {
            Text(currentTask.name)
            Text(timeUsedOnProject, style: .timer)
            Text(timeUsedToday, style: .timer)
        }
    }
    
    // TODO: Move this function to another file
    func getStartDateForTimer(amountOfSeconds: Int) -> Date {
        
        // The start date is the current time minus the amount of time spend on the
        // project already. Then the timer will show the time spend increasing
        
        let timerStartTime = Calendar.current.date(
            byAdding: .second, value: -amountOfSeconds, to: .now
        )
        return timerStartTime ?? .now
    }
}

#Preview {
    BottomInfo(
        timeRegistrations: [],
        secondsSpendTotalToday: 31500,
        secondsSpendOnCurrentProjectTotalToday: 9000
    )
}
