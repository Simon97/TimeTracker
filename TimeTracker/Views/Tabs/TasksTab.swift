//
//  TasksTab.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 14/02/2024.
//

import SwiftUI

struct TasksTab: View {
    
    var tasks: [Task]
    
    var body: some View {
        NavigationStack {
            VStack {
                TaskListView(tasks: tasks)
                
                BottomInfo(
                    currentProject: "Some project",
                    secondsSpendTotalToday: 60 * 60 * 2 + 125,
                    secondsSpendOnCurrentProjectTotalToday: 60 * 60 * 3
                )
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
    TasksTab(tasks: [])
}
