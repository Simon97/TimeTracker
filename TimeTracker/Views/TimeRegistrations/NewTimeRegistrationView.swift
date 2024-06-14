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
        startTime: .now,
        activity: nil
    )
    
    @Query var timeRegistrations: [TimeRegistration]
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        
        let binding = Binding(
            get: { self.newTimeRegistration },
            set: {
                print("Started saving")
                
                self.newTimeRegistration = $0 // TODO: I do not think this is needed
                print("(0)", "\($0)")
                
                // We know that the TimeRegistrationEditView will only set the Binding once, which is why this works
                
                TimeRegistrationController()
                    .addTimeRegistration(
                        self.newTimeRegistration,
                        timeRegistrations: timeRegistrations,
                        modelContext: modelContext
                    )
                print("Did save")
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
