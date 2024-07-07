//
//  PausableTimerView.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 05/07/2024.
//

import SwiftUI

struct PausableTimerView: View {
    
    let interval: TimeInterval
    let isPaused: Bool
    
    var body: some View {
        if isPaused {
            Text(TimeIntervalFormatter().format(timeInterval: interval))
        } else {
            let timerStartTime = Calendar.current.date(
                byAdding: .second, value: Int(-interval), to: .now
            )
            Text(timerStartTime ?? .now, style: .timer)
        }
    }
}

#Preview {
    PausableTimerView(interval: 1000, isPaused: false)
}
