//
//  BottomInfo.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 16/01/2024.
//

import SwiftUI

struct BottomInfo: View {
    
    
    var timeRegistrations: TimeRegistrationsViewModel
    
    var lastTimeRegistration: TimeRegistration {
        return timeRegistrations.registrations.first ?? TimeRegistration(startTime: .now, endTime: .now, task: .noTask())
    }
    
    var currentTask: Task {
        return timeRegistrations.registrations.first?.task ?? .noTask()
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
        HStack {
            Text(currentTask.name)
                .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12))
            Spacer()
            HStack {
                VStack {
                    Text(timeUsedOnProject, style: .timer)
                    Text(timeUsedToday, style: .timer)
                }
            
                PlayPauseButton(state: .playing, action: {})
                    .frame(width: 42)
                    .padding(EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12))
            }
        }
        .frame(maxWidth: .infinity)
        .background(.teal)
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
    BottomInfo(timeRegistrations: TimeRegistrationsViewModel(registrations: []))
}
