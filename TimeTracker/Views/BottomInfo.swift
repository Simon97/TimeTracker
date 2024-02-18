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
        return timeRegistrations.registrations.first ?? TimeRegistration(startTime: .now, task: .noTask())
    }
    
    var currentTask: Task? {
        timeRegistrations.currentTask
    }
    
    var currentProject: Project? {
        return currentTask?.project
    }
    
    var startTimeForTimerTaskTimeToday: Date {
        getStartDateForTimer(amountOfSeconds: timeRegistrations.timeSpendOnTaskToday)
    }
        
    var isPlaying: Bool {
        timeRegistrations.currentTimeRegistration?.endTime == nil
    }
    
    var body: some View {
        HStack {
            if let currentTask = currentTask {
                VStack {
                    Text(currentTask.name)
                        .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12))
                    // Spacer()
                    HStack {
                        VStack {
                            HStack() {
                                Text("On task today: ")
                                Spacer()
                                
                                if isPlaying {
                                    Text(startTimeForTimerTaskTimeToday, style: .timer)
                                } else {
                                    /* TODO: Show the paused time ...
                                    Text(startTimeForTimerTaskTimeToday.compare(timeRegistrations.currentTimeRegistration?.endTime))
                                     */
                                }
                            }
                        }
                    }
                }
                
                PlayPauseButton(
                    isPlaying: isPlaying,
                    action: {
                        // TODO: This should be fixed ...
                        if isPlaying {
                            timeRegistrations.currentTimeRegistration?.endTime = .now
                        } else {
                            let newReg = TimeRegistration(
                                startTime: .now,
                                task: timeRegistrations.currentTimeRegistration?.task ??
                                Task("Gamer task", isFavorite: false) // TODO: fix ..
                            )
                            timeRegistrations.appendRegistration(newReg)
                        }
                    }
                )
                .frame(width: 42)
                .padding(EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12))
                
            } else {
                Text("Pick a task to start time tracking...")
            }
        }
        .frame(height: 50)
        .frame(maxWidth: .infinity)
    }
    
    
    
    // TODO: Move this function to another file
    func getStartDateForTimer(amountOfSeconds: Double) -> Date {
        
        // The start date is the current time minus the amount of time spend on the
        // project already. Then the timer will show the time spend increasing
        
        let timerStartTime = Calendar.current.date(
            // TODO: consider this weird convertion between Int and Double
            byAdding: .second, value: Int(-amountOfSeconds), to: .now
        )
        return timerStartTime ?? .now
    }
}

#Preview {
    BottomInfo(timeRegistrations: TimeRegistrationsViewModel(registrations: []))
}
