//
//  TimeRegistrationEditView.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 09/05/2024.
//

import SwiftUI
import SwiftData

struct TimeRegistrationEditView: View {
    
    var isNew = false
    
    @Query(sort:\Activity.name) private var activities: [Activity]
    
    @Bindable var timeRegistration: TimeRegistration
    
    @State private var activityName: String?
    @State private var startTime: Date
    @State private var endTime: Date
    
    @Environment(\.dismiss) private var dismiss
    
    init(
        timeRegistration: TimeRegistration, isNew: Bool = false) {
            self.startTime = timeRegistration.startTime
            self.endTime = timeRegistration.endTime ?? .now
            self.activityName = timeRegistration.activity?.name
            self.isNew = isNew
            self.timeRegistration = timeRegistration
        }
    
    let helpTextNew = "Here, you can add a missing registration, if you forgot to track some time"
    let helpTextEdit = "Here, you can adjust the start and end time for a given Time Registration, in case you forgot to start or stop the tracking"
    
    var timeRegistrationCheckerResponse: TimeRegistrationCheckerResponse {
        
        // Constructing a TimeRegistration obj just for this
        let localReg = TimeRegistration(startTime: startTime, activity: Activity("Dummy"))
        localReg.endTime = endTime
        
        let result = TimeRegistrationChecker
        // .check(timeRegistration: localReg) TODO: At some point, this should be used to potientially find multiple differnet errors
            .checkStartBeforeEnd(timeRegistration: localReg)
        return result
    }
    
    var body: some View {
        
        return VStack(alignment: .leading) {
            
            HStack() {
                Text("Activity:")
                Spacer()
                Picker("Activity", selection: $activityName) {
                    Text("None")
                        .tag(nil as String?)
                    
                    
                    ForEach(activities) { activity in
                        Text(activity.name)
                            .tag(activity.name as String?)
                    }
                }
                
                
            }
            
            Divider()
            
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
                
                if !isNew {
                    Button {
                        startTime = timeRegistration.startTime
                        endTime = timeRegistration.endTime ?? .now
                        activityName = timeRegistration.activity?.name
                    } label: {
                        Text("Reset")
                    }
                    .disabled(
                        startTime == timeRegistration.startTime &&
                        endTime == timeRegistration.endTime
                        && activityName == timeRegistration.activity?.name
                    )
                }
                
                Button {
                    timeRegistration.startTime = startTime
                    timeRegistration.endTime = endTime
                    
                    // To reset to the original activity, we need to find the one with the right name
                    // Because of this, the activities should have different names
                    timeRegistration.activity = activities.first { a in
                        a.name == activityName
                    }
                    
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
        .modelContainer(SampleData.shared.modelContainer)
    }
}

#Preview("Edit") {
    NavigationStack {
        TimeRegistrationEditView(
            timeRegistration: SampleData.shared.timeRegistrationCompleted,
            isNew: false
        )
        .modelContainer(SampleData.shared.modelContainer)
    }
}

