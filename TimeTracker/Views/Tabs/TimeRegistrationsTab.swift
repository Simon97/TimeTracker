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
    
    
    var body: some View {
        NavigationStack {
            
            // TODO: This view needs some kind of DatePicker, making it possible to show how much time spend on different days
            
            
            
            List {
                Section("Total time on activities") {
                    ForEach(activities) { activity in
                        // TODO: Make a new View for this.
                        
                        let interval = controller.timeSpendOnActivityonDate(timeRegistrations, activity: activity, date: .now)
                        
                        if controller.newestTimeRegistrationInList(timeRegistrations)?.activity == activity &&
                            controller.newestTimeRegistrationInList(timeRegistrations)?.endTime == nil {
                            let timerStartTime = Calendar.current.date(
                                byAdding: .second, value: Int(-interval), to: .now
                            )
                            HStack {
                                Text("\(activity.name):")
                                Spacer()
                                Text(timerStartTime ?? .now, style: .timer)
                            }
                            .bold()
                            
                        } else {
                            HStack {
                                Text("\(activity.name):")
                                Spacer()
                                Text(TimeIntervalFormatter().format(timeInterval: interval))
                            }
                        }
                    }
                }
                
                Section("Registrations (\(timeRegistrations.count))") {
                    ForEach(timeRegistrations) { registration in
                        
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
            .toolbar {
                if activities.first != nil {
                    ToolbarItem {
                        NavigationLink {
                            NewTimeRegistrationView()
                            
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
