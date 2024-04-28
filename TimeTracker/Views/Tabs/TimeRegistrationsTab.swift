//
//  TimeRegistrationsTab.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 14/02/2024.
//

import SwiftUI
import SwiftData

struct TimeRegistrationsTab: View {
    
    @Query private var timeRegistrations: [TimeRegistration]
    
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

/*
#Preview {
    TimeRegistrationsTab(timeRegistrations: [])
}
 */

extension TimeRegistrationsTab {
    
    @Observable
    class ViewModel {
        
        var timeRegistrations: [TimeRegistration]
        
        init(timeRegistrations: [TimeRegistration]) {
            self.timeRegistrations = timeRegistrations
        }
    }
    
}
