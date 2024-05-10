//
//  TimeRegistrationEditView.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 09/05/2024.
//

import SwiftUI

/**
 The idea is a "standard" edit view which can also be used to create new entities.
 But I am not sure if the user needs more in order to fix mistakes with registrations they forgot to start
 or stop. And after "fixing" them, some registrations might be overlapping
 */

struct TimeRegistrationEditView: View {
    
    var isNew = false
    @Bindable var timeRegistration: TimeRegistration
    
    @Environment(\.dismiss) private var dismiss
    
    init(timeRegistration: TimeRegistration, isNew: Bool = false) {
        self.timeRegistration = timeRegistration
        self.isNew = isNew
    }
    
    let helpTextNew = "Here, you can add missing registrations, if you forgot to track some time"
    let helpTextEdit = "Here, you can adjust the start and end time for a given Time Registration, in case you forgot to start or stop the tracking"
    
    var timeRegistrationCheckerResponse: TimeRegistrationCheckerResponse {
        let result = TimeRegistrationChecker
            .checkStartBeforeEnd(timeRegistration: timeRegistration)
        return result
    }
    
    var body: some View {
        
        VStack(alignment: .leading) {
            DatePicker(
                "Start time",
                selection: $timeRegistration.startTime,
                displayedComponents: [.hourAndMinute]
            )
            
            DatePicker(
                "End time",
                selection: $timeRegistration.endTime.withDefault(value: .now),
                displayedComponents: [.hourAndMinute]
            )
            
            if !timeRegistrationCheckerResponse.isGood {
                Text(timeRegistrationCheckerResponse.errorMessage ?? "")
                    .foregroundStyle(Color.red)
                    .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
                    .frame(maxWidth: .infinity)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(.red, lineWidth: 1)
                    )
            }
            
            Text(isNew ? helpTextNew : helpTextEdit)
                .padding()
                .overlay(
                    
                    // TODO: Add some kind of lightbulb to indicate a hint
                    
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(.primary, lineWidth: 1)
                )
                .frame(maxWidth: .infinity)
                .padding(EdgeInsets(top: 16, leading: 0, bottom: 32, trailing: 0))
            
            
            HStack {
                Button {
                    dismiss()
                } label: {
                    Text("Done")
                }
            }
            .frame(maxWidth: .infinity)
            
            Spacer()
        }
        .padding()
        .navigationTitle(isNew ? "Add Registration" : "Edit Registration")
    }
}

#Preview("New") {
    NavigationStack {
        TimeRegistrationEditView(
            timeRegistration: SampleData.shared.timeRegistrationCompleted,
            isNew: true
        )
    }
}

#Preview("Edit") {
    NavigationStack {
        TimeRegistrationEditView(
            timeRegistration: SampleData.shared.timeRegistrationCompleted,
            isNew: false
        )
    }
}

