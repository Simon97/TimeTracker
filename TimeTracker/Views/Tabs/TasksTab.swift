//
//  TasksTab.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 14/02/2024.
//

import SwiftUI

struct TasksTab: View {
    
    var tasks: [Task]
    var timeRegistrations: [TimeRegistration]
    
    var body: some View {
        NavigationStack {
            VStack {
                TaskListView(tasks: tasks)
                
                BottomInfo(timeRegistrations: timeRegistrations)
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
    TasksTab(tasks: [], timeRegistrations: [])
}
