//
//  TasksTab.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 14/02/2024.
//

import SwiftUI

struct TasksTab: View {
    
    var tasks: [Task]
    var timeRegistrations: TimeRegistrationsViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                TaskListView(tasks: tasks, timeRegistrations: timeRegistrations)
                Divider()
                BottomInfo(timeRegistrations: timeRegistrations)
                Divider()
            }
            .navigationTitle("Tasks")
        }
        .tabItem {
            Label("Tasks", systemImage: "star")
        }
        .tag(Tab.favorites)
    }
}

#Preview {
    // TODO: Add content to show
    TasksTab(
        tasks: [
            Task("Test task", isFavorite: false),
            Task("Test task 2", isFavorite: true)
        ],
        timeRegistrations: TimeRegistrationsViewModel(registrations: [])
    )
}
