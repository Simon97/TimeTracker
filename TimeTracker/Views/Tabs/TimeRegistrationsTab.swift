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
                /*
                Section("Time spend on:") {
                    
                    // TODO: Make all this work for sub-projects as well ...
                    
                    ForEach(projects) { project in
                        VStack(alignment: .leading) {
                            Text(project.name)
                            ForEach(project.tasks, id: \.uuid) { task in
                                HStack() {
                                    Text("\(task.name):")
                                    // TODO: This should be cleaned up
                                    
                                    Spacer()
                                    
                                    Text(Duration(timeval(tv_sec: Int(timeRegistrations.timeSpendOnGivenTaskToday(task: task)), tv_usec: 0))
                                        .formatted(.time(pattern: .hourMinuteSecond)))
                                }
                                .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 0))
                            }
                        }
                    }
                }
                */
                
                Section("Registrations") {
                    /*
                    ForEach(timeRegistrations.registrations) { registration in
                        TimeRegistrationView(timeRegistration: registration)
                    }
                    */
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
    TimeRegistrationsTab(timeRegistrations: TimeRegistrationsViewModel(registrations: []))
}
