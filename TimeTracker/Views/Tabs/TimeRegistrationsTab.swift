//
//  TimeRegistrationsTab.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 14/02/2024.
//

import SwiftUI

struct TimeRegistrationsTab: View {
    
    var timeRegistrations = [TimeRegistration]()
    
    var body: some View {
        NavigationStack {
            List {
                Section("Registrations") {
                    ForEach(timeRegistrations) { registration in
                        TimeRegistrationView(timeRegistration: registration)
                    }
                }
            }
            .listStyle(.plain)

            // BottomInfo(timeRegistrations: timeRegistrations.registrations)
            
            .navigationTitle("Time Registrations")
        }
        .tabItem {
            Label("Time Registrations", systemImage: "stopwatch")
        }
        .tag(Tab.timeRegistrations)
    }
}

#Preview {
    TimeRegistrationsTab(timeRegistrations: [])
}
