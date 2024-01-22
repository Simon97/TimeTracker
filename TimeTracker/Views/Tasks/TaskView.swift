//
//  TaskView.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 19/01/2024.
//

import SwiftUI

struct TaskView: View {
    
    @Binding var task: Task
    
    var body: some View {
        HStack{
            FavoriteButton(isFavourite: $task.isFavorite)
            Text(task.name)
        }
    }
}

#Preview {
    return Group {
        // Not the same task
        TaskView(task: .constant( Task("Project name", isFavorite: true)))
    }
}
