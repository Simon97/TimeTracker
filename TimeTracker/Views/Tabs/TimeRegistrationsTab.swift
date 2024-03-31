//
//  TimeRegistrationsTab.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 14/02/2024.
//

import SwiftUI

struct TimeRegistrationsTab: View {
    
    var timeRegistrations: TimeRegistrationsViewModel
    
    var body: some View {
        NavigationStack {
            List {
                Section("Registrations") {
                    ForEach(timeRegistrations.registrations) { registration in
                        TimeRegistrationView(timeRegistration: registration)
                    }
                }
            }
            .listStyle(.plain)

            BottomInfo(timeRegistrations: timeRegistrations)
            
            .navigationTitle("Time Registrations")
        }
        .tabItem {
            Label("Time Registrations", systemImage: "stopwatch")
        }
        .tag(Tab.timeRegistrations)
    }
}

#Preview {
    TimeRegistrationsTab(timeRegistrations: TimeRegistrationsViewModel(registrations: []))
}
