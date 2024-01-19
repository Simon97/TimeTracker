//
//  BottomInfo.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 16/01/2024.
//

import SwiftUI

struct BottomInfo: View {
    
    let currentProject: String
    
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
            Text(currentProject)
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
        currentProject: "Current project",
        secondsSpendTotalToday: 31500,
        secondsSpendOnCurrentProjectTotalToday: 9000
    )
}
