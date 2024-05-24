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
    
    @State private var activityId: UUID?
    @State private var startTime: Date
    @State private var endTime: Date
    
    @Environment(\.dismiss) private var dismiss
    
    init(
        timeRegistration: TimeRegistration, isNew: Bool = false) {
            self.startTime = timeRegistration.startTime
            self.endTime = timeRegistration.endTime ?? .now
            self.activityId = timeRegistration.activity?.uuid
            self.isNew = isNew
            self.timeRegistration = timeRegistration
        }
    
    let helpTextNew = "Here, you can add a missing registration, if you forgot to track some time"
    let helpTextEdit = "Here, you can adjust the start and end time for a given Time Registration, in case you forgot to start or stop the tracking"
    
    
    var timeRegistrationCheckerResponses: [TimeRegistrationCheckerResponse] {
        let checkerRegistration = TimeRegistrationCheckerInput(
            startTime: startTime,
            endTime: endTime,
            activity: activities.first{ a in
            a.uuid == activityId
        })
        let checker = TimeRegistrationChecker()
        return checker.check(timeRegistration: checkerRegistration)
    }
    
    var anyErrors: Bool {
        let oneWithError = timeRegistrationCheckerResponses.firstIndex(where: { response in
            response.hasError
        })
        return oneWithError != nil
    }
    
    var body: some View {
        
        return VStack(alignment: .leading) {
            
            HStack() {
                Text("Activity:")
                Spacer()
                Picker("Activity", selection: $activityId) {
                    Text("None")
                        .tag(nil as UUID?)
                    
                    ForEach(activities) { activity in
                        Text(activity.name)
                            .tag(activity.uuid as UUID?)
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
            
            ForEach(timeRegistrationCheckerResponses, id: \.errorMessage) { response in
                if response.hasError {
                    Text(response.errorMessage ?? "")
                        .foregroundStyle(Color.red)
                        .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
                        .frame(maxWidth: .infinity)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(.red, lineWidth: 1)
                        )
                }
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
                        activityId = timeRegistration.activity?.uuid
                    } label: {
                        Text("Reset")
                    }
                    .disabled(
                        startTime == timeRegistration.startTime &&
                        endTime == timeRegistration.endTime
                        && activityId == timeRegistration.activity?.uuid
                    )
                }
                
                Button {
                    timeRegistration.startTime = startTime
                    timeRegistration.endTime = endTime
                    
                    timeRegistration.activity = activities.first { a in
                        a.uuid == activityId
                    }
                    
                    dismiss()
                } label: {
                    Text("Save")
                }
                .disabled(anyErrors)
            }
            .frame(maxWidth: .infinity)
            
            Spacer()
        }
        .padding()
        .navigationTitle(isNew ? "New Registration" : "Edit Registration")
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

