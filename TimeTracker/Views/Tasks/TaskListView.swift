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
    @State private var showFavoritesOnly: Bool = false
    
    var filteredTasks: [Task] {
        tasks.filter { task in
            (!showFavoritesOnly || task.isFavorite)
        }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                Toggle(isOn: $showFavoritesOnly) {
                    Text("Favorites only")
                }
                
                ForEach(filteredTasks) { task in
                    TaskView(showProjectName: true, task: .constant(task))
                    if filteredTasks.last != task {
                        Divider()
                            .padding(4)
                    }
                }
            }
            .padding()
        }
        
        if filteredTasks.isEmpty {
            if showFavoritesOnly {
                Text("No favorites")
            } else {
                Text("No tasks")
            }
        }
        
    }
}

#Preview {
    TaskListView(tasks: [
        Task("Task", isFavorite: true),
        Task("Task", isFavorite: true),
    ])
}
