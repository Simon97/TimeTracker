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
            ScrollView {
                VStack {
                    ForEach(timeRegistrations.registrations) { registration in
                        TimeRegistrationView(timeRegistration: registration)
                            .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
                        Divider()
                    }
                }
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
    TimeRegistrationsTab(timeRegistrations: TimeRegistrationsViewModel(registrations: []))
}
