//
//  TimeRegistrationsTab.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 14/02/2024.
//

import SwiftUI
import SwiftData

struct TimeRegistrationsTab: View {
    
    @Query(sort: \TimeRegistration.startTime)
    private var timeRegistrations: [TimeRegistration]
    
    @Query var activities: [Activity]
    
    var controller = TimeRegistrationController()
    
    
    var body: some View {
        NavigationStack {
            List {
                Section("Total time on activities") {
                    ForEach(activities) { activity in
                        // TODO: Make a new View for this.
                        // ... If we are currently doing (tracking) on the given activity, the timer should work as in the TrackingControllerView
                        
                        let interval = controller.timeSpendOnActivityonDate(timeRegistrations, activity: activity, date: .now)
                        
                        
                        Text("\(activity.name): \(controller.formatToTime(amountOfSeconds: interval))")
                    }
                }
                
                Section("Registrations (\(timeRegistrations.count))") {
                    ForEach(timeRegistrations) { registration in
                        TimeRegistrationView(timeRegistration: registration)
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Time Registrations")
        }
        .tabItem {
            Label("Time Registrations", systemImage: "stopwatch")
        }
        .tag(Tab.timeRegistrations)
    }
}

#Preview {
    TimeRegistrationsTab()
        .modelContainer(SampleData.shared.modelContainer)
}
