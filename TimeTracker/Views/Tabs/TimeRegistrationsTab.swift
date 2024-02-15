//
//  TimeRegistrationsTab.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 14/02/2024.
//

import SwiftUI

struct TimeRegistrationsTab: View {
    
    // @Environment(TimeRegistrations.self) var timeRegistrationsWrapper
    
    var timeRegistrations: [TimeRegistration]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    ForEach(timeRegistrations) { registration in
                        HStack {
                            Text(registration.task.name)
                            Text(registration.task.project?.name ?? "")
                            Text(String(
                                registration.startTime.timeIntervalSince1970
                            ))
                        }
                        .padding(12)
                    }
                }
                .padding()
            }
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
