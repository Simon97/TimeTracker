//
//  TimeRegistrationView.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 17/02/2024.
//

import SwiftUI

struct TimeRegistrationView: View {
    
    var timeRegistration: TimeRegistration
    
    var body: some View {
        HStack {
            Text(timeRegistration.activity.name)
            Text(timeRegistration.startTime.formatted())
            if timeRegistration.endTime != nil {
                Text((timeRegistration.endTime)?.formatted() ?? "")
            }
        }
    }
}
