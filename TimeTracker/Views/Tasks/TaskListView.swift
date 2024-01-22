//
//  TaskListView.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 21/01/2024.
//

import SwiftData
import SwiftUI

struct TaskListView: View {
    
    @State var tasks: [Task]
    @State private var showFavoritesOnly: Bool = false
    
    var filteredTasks: [Task] {
        tasks.filter { task in
            (!showFavoritesOnly || task.isFavorite)
        }
    }
    
    var body: some View {
        List {
            Toggle(isOn: $showFavoritesOnly) {
                Text("Favorites only")
            }
            
            ForEach(filteredTasks) { task in
                TaskView(task: .constant(task))
            }
        }
    }
}

#Preview {
    TaskListView(tasks: [Task("Task", isFavorite: true)])
}
