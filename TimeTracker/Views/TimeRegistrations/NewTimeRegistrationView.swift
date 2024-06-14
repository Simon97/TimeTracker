//
//  NewTimeRegistrationView.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 19/05/2024.
//

import SwiftUI
import SwiftData

struct NewTimeRegistrationView: View {
    
    @State private var newTimeRegistration = TimeRegistration(
        startTime: .now, // TODO: This becomes the time when the app is opened and not the current time, since the state is made at that point in time.
        activity: nil
    )
    
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        let binding = Binding(
            get: { self.newTimeRegistration },
            set: {
                self.newTimeRegistration = $0
                modelContext.insert(newTimeRegistration) // We know that the TimeRegistrationEditView will only set the Binding once, which is why this works
            }
        )
        
        TimeRegistrationEditView(
            timeRegistration: binding.wrappedValue,
            isNew: true
        )
    }
}

#Preview {
    NewTimeRegistrationView()
        .modelContainer(SampleData.shared.modelContainer)
}
