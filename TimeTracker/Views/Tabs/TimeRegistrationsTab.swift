//
//  TimeRegistrationsTab.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 14/02/2024.
//

import SwiftUI
import SwiftData

struct TimeRegistrationsTab: View {
    
    @Query(sort: \TimeRegistration.startTime, order: .reverse)
    private var timeRegistrations: [TimeRegistration]
    
    @Query(sort:\Activity.name) var activities: [Activity]
    
    var controller = TimeRegistrationController()
    
    @Environment(\.modelContext) private var modelContext
    
    @State private var date = Date.now
    
    private var filteredRegistrations: [TimeRegistration] {
        return timeRegistrations.filter { registration in
            let sameDay = Calendar.current.isDate(registration.startTime, equalTo: date, toGranularity: .day)
            
            return sameDay
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                DatePicker("Date", selection: $date, displayedComponents: [.date])
                
                // TODO: Clean this up. Make some better functions and use them..
                if controller.isRegistrationOnGoing(
                    timeRegistrations: filteredRegistrations
                ) {
                    let timerStartTime = Calendar.current.date(
                        byAdding: .second, value: Int(-controller.totalTimeForRegistrations(timeRegistrations: filteredRegistrations)), to: .now
                    )
                    HStack {
                        Text("Total time on selected day:")
                        Spacer()
                        Text(timerStartTime ?? .now, style: .timer)
                    }
                } else {
                    HStack {
                        Text("Total time on selected day:")
                        Spacer()
                        Text(TimeIntervalFormatter().format(timeInterval:  controller.totalTimeForRegistrations(timeRegistrations: filteredRegistrations)))
                    }
                }
                
                
                
                // TODO: Remove 0:00 registrations ?
                Section("Total time on activities") {
                    ForEach(activities.filter { activity in
                        !activity.timeRegistrations.isEmpty
                    }) { activity in
                        // TODO: Make a new View for this.
                        
                        let interval = controller.timeSpendOnActivityonDate(
                            filteredRegistrations,
                            activity: activity,date: date
                        )
                        let isRegistrationOnGoingForActivity = controller.findLastAddedRegistration(
                            filteredRegistrations)?.activity == activity &&
                        controller.findLastAddedRegistration(filteredRegistrations)?.endTime == nil
                        
                        HStack {
                            Text("\(activity.name):")
                            Spacer()
                            PausableTimerView(interval: interval, isPaused: !isRegistrationOnGoingForActivity)
                        }
                    }
                }
                
                if filteredRegistrations.isEmpty {
                    Text("No registrations made at the selected date")
                        .listRowBackground(Color.clear)
                    
                } else {
                    Section("Registrations (\(filteredRegistrations.count))") {
                        ForEach(filteredRegistrations) { registration in
                            NavigationLink {
                                TimeRegistrationEditView(
                                    timeRegistration: registration
                                )
                            } label: {
                                TimeRegistrationView(
                                    timeRegistration: registration
                                )
                            }
                        }
                        .onDelete(perform: deleteItems)
                    }
                }
            }
            .toolbar {
                if activities.first != nil {
                    ToolbarItem {
                        NavigationLink {
                            NewTimeRegistrationView(timeRegistrations: timeRegistrations)
                            
                        } label: {
                            Image(systemName: "plus")
                                .foregroundStyle(.teal)
                        }
                    }
                }
            }
            .navigationTitle("Time Registrations")
            // .listStyle(.plain)
        }
        .tabItem {
            Label(Tab.timeRegistrations.rawValue, systemImage: "stopwatch")
        }
        .tag(Tab.timeRegistrations)
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(timeRegistrations[index])
            }
        }
    }
}

#Preview {
    TimeRegistrationsTab()
        .modelContainer(SampleData.shared.modelContainer)
}
