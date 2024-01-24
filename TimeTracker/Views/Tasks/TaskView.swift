//
//  TaskView.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 19/01/2024.
//

import SwiftUI

struct TaskView: View {
    
    @Binding var task: Task
    let selected: Bool = true
    
    var body: some View {
        HStack {
            FavoriteButton(isFavourite: $task.isFavorite)
            HStack {
                Text(task.name)
            }
            .frame(maxWidth: .infinity)
            // .background(.orange)
        }
    }
}

#Preview {
    return Group {
        // Not the same task
        TaskView(task: .constant( Task("Task name", isFavorite: true)))
    }
}
