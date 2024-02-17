//
//  BottomInfo.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 16/01/2024.
//

import SwiftUI

struct BottomInfo: View {
    
    // TODO: Experiment with how to move the logic to another file
    
    var timeRegistrations: [TimeRegistration]
    
    var lastTimeRegistration: TimeRegistration {
        return timeRegistrations.first ?? TimeRegistration(startTime: .now, endTime: .now, task: .noTask())
    }
    
    var currentTask: Task {
        return timeRegistrations.first?.task ?? .noTask()
    }
    
    var currentProject: Project {
        return currentTask.project ?? Project("", isMainProject: false, isCollapsed: false)
    }
    
    var timeUsedOnProject: Date {
        getStartDateForTimer(amountOfSeconds: 0)
    }
    
    var timeUsedToday: Date {
        getStartDateForTimer(amountOfSeconds: 0)
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
    BottomInfo(timeRegistrations: [])
}
