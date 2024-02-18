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
            VStack {
                Text("Task: \(timeRegistration.task.name)")
                Text("Project: \(timeRegistration.task.project?.name ?? "")")
            }
            Spacer()
            VStack {
                Text(timeRegistration.startTime, style: .time)
                if timeRegistration.endTime != nil {
                    let endTime: Date = timeRegistration.endTime!
                    Text(endTime, style: .time)
                }
            }
        }
    }
}

#Preview {
    TimeRegistrationView(timeRegistration: TimeRegistration(startTime: .now, task: .noTask()))
}
