//
//  TimeRegistrationsTab.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 14/02/2024.
//

import SwiftUI

struct TimeRegistrationsTab: View {
    
    @State private var viewModel: ViewModel
    init(timeRegistrations: [TimeRegistration]) {
        self.viewModel = ViewModel(timeRegistrations: timeRegistrations)
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section("Registrations (\(viewModel.timeRegistrations.count))") {
                    
                    ForEach(viewModel.timeRegistrations) { registration in
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
