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
    
    var body: some View {
        NavigationStack {
            List {
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
