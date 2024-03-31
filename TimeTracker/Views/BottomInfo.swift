//
//  BottomInfo.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 16/01/2024.
//

import SwiftUI

struct BottomInfo: View {
    
    @State private var isPlaying = false
    
    var timeRegistrations: TimeRegistrationsViewModel
    
    var body: some View {
        HStack {
            
            VStack {
                Text("Current activity name ...")
                Text("Time spend on task? Or time in total?")
            }
            
            PlayPauseButton(isPlaying: isPlaying, action: {isPlaying.toggle()})
                .frame(width: 42)
        }
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

#Preview(traits: .sizeThatFitsLayout) {
    BottomInfo(timeRegistrations: TimeRegistrationsViewModel(registrations: []))
}
