//
//  BottomInfo.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 16/01/2024.
//

import SwiftUI

struct BottomInfo: View {
    
    var timeRegistrations: TimeRegistrationsViewModel
    
    
    var body: some View {
        Text("Wait")
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
