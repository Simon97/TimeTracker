//
//  NewTimeRegistrationView.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 19/05/2024.
//

import SwiftUI
import SwiftData

struct NewTimeRegistrationView: View {
    
    let timeRegistrations: [TimeRegistration]
    
    @State private var newTimeRegistration = TimeRegistration(
        startTime: .now,
        activity: nil
    )
    
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        TimeRegistrationEditView(
            timeRegistration: newTimeRegistration,
            isNew: true,
            onSave: {
                TimeRegistrationController()
                    .addTimeRegistration(
                        self.newTimeRegistration,
                        timeRegistrations: timeRegistrations,
                        modelContext: modelContext
                    )
            }
        )
    }
}

#Preview {
    NewTimeRegistrationView(timeRegistrations: [])
        .modelContainer(SampleData.shared.modelContainer)
}
