//
//  TaskListView.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 21/01/2024.
//

import SwiftData
import SwiftUI

struct TaskListView: View {
    
    var tasks: [Task]
    var timeRegistrations: TimeRegistrationsViewModel
    
    @AppStorage("onlyFavorites") private var onlyFavorites = false
    
    var filteredTasks: [Task] {
        tasks.filter { task in
            (!onlyFavorites || task.isFavorite)
        }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                Toggle(isOn: $onlyFavorites) {
                    Text("Favorites only")
                }
                
                ForEach(filteredTasks) { task in
                    TaskView(
                        isTaskSelector: true,
                        task: task,
                        timeRegistrations: timeRegistrations,
                        showProjectName: true
                    )
                    if filteredTasks.last != task {
                        Divider()
                            .padding(4)
                    }
                }
            }
            .padding()
            
            if filteredTasks.isEmpty {
                if onlyFavorites {
                    Text("No favorites")
                } else {
                    Text("No tasks")
                }
            }
            
        }
    }
}

#Preview {
    TaskListView(
        tasks: [
            Task("Task", isFavorite: true),
            Task("Task", isFavorite: true)
        ],
        timeRegistrations: TimeRegistrationsViewModel(registrations: [])
    )
}
