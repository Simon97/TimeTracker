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
    
    // TimeRegistraion to be updated when save is pressed
    @Bindable var timeRegistration: TimeRegistration
    
    let onSave: () -> Void
    
    @State private var activityId: UUID?
    @State private var startTime: Date
    @State private var endTime: Date?
    
    @Environment(\.dismiss) private var dismiss
    
    init(
        timeRegistration: TimeRegistration,
        isNew: Bool = false,
        onSave: @escaping () -> Void = {}) {
            self.startTime = timeRegistration.startTime
            self.endTime = timeRegistration.endTime
            self.activityId = timeRegistration.activity?.uuid
            
            self.isNew = isNew
            self.timeRegistration = timeRegistration
            self.onSave = onSave
        }
    
    let helpTextNew = "Here, you can add a missing registration, if you forgot to track some time"
    let helpTextEdit = "Here, you can adjust the start and end time for a given Time Registration, in case you forgot to start or stop the tracking"
    
    var timeRegistrationCheckerResponses: [TimeRegistrationCheckerResponse] {
        let checkerRegistration = TimeRegistrationCheckerInput(
            startTime: startTime,
            endTime: endTime,
            activity: activities.first { a in
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
            
            ScrollView {
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
                
                if endTime == nil {
                    Button {
                        endTime = .now
                    } label: {
                        Text("Add endtime")
                    }
                    
                } else {
                    DatePicker(
                        "End time",
                        selection: $endTime.withDefault(value: .now),
                        displayedComponents: [.hourAndMinute]
                    )
                }
                
                ForEach(timeRegistrationCheckerResponses.filter { response in
                    response.hasError == true // TODO: Maybe only return responses wih error ?
                }, id: \.errorMessage) { response in
                    if response.hasError {
                        ErrorMessageBox(
                            errorMessage: response.errorMessage ?? ""
                        )
                        .padding(.bottom, 2)
                    }
                }
                .padding(.top, 8)
                
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
                            endTime = timeRegistration.endTime
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
                        timeRegistration.endTime = endTime
                        timeRegistration.startTime = startTime
                        timeRegistration.activity = activities.first { a in
                            a.uuid == activityId
                        }
                        onSave()
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
}

#Preview {
    NavigationStack {
        TimeRegistrationEditView(
            timeRegistration: SampleData.shared.timeRegistrationCompleted,
            isNew: false
        )
        .modelContainer(SampleData.shared.modelContainer)
    }
}

#Preview("Ongoing") {
    NavigationStack {
        TimeRegistrationEditView(
            timeRegistration: SampleData.shared.timeRegistrationOngoing,
            isNew: false
        )
        .modelContainer(SampleData.shared.modelContainer)
    }
}
