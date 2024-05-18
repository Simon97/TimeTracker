//
//  TimeRegistrationEditView.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 09/05/2024.
//

import SwiftUI

struct TimeRegistrationEditView: View {
    
    var isNew = false
    
    @Bindable var timeRegistration: TimeRegistration
    
    @State var startTime: Date
    @State var endTime: Date
    
    @Environment(\.dismiss) private var dismiss
    
    init(timeRegistration: TimeRegistration, isNew: Bool = false) {
        self.timeRegistration = timeRegistration
        
        self.startTime = timeRegistration.startTime
        self.endTime = timeRegistration.endTime ?? .now
        
        self.isNew = isNew
    }
    
    let helpTextNew = "Here, you can add missing registrations, if you forgot to track some time"
    let helpTextEdit = "Here, you can adjust the start and end time for a given Time Registration, in case you forgot to start or stop the tracking"
    
    var timeRegistrationCheckerResponse: TimeRegistrationCheckerResponse {
        
        // Constructing a TimeRegistration obj just for this
        let localReg = TimeRegistration(startTime: startTime, activity: Activity("Dummy"))
        localReg.endTime = endTime
        
        let result = TimeRegistrationChecker
            .checkStartBeforeEnd(timeRegistration: localReg)
        return result
    }
    
    var body: some View {
        
        VStack(alignment: .leading) {
            DatePicker(
                "Start time",
                selection: $startTime,
                displayedComponents: [.hourAndMinute]
            )
            
            DatePicker(
                "End time",
                selection: $endTime, //.withDefault(value: .now),
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
            
            
            HStack(spacing: 32) {
                Button {
                    startTime = timeRegistration.startTime
                    endTime = timeRegistration.endTime ?? .now
                } label: {
                    Text("Reset")
                }
                .disabled(startTime == timeRegistration.startTime && endTime == timeRegistration.endTime)
                
                Button {
                    timeRegistration.startTime = startTime
                    timeRegistration.endTime = endTime
                    dismiss()
                } label: {
                    Text("Save")
                }
                .disabled(!timeRegistrationCheckerResponse.isGood)
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

