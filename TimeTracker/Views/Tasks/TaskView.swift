//
//  TaskView.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 19/01/2024.
//

import SwiftUI

struct TaskView: View {
    
    let showProjectName: Bool
    
    @Binding var task: Task
    let selected: Bool = true
    
    var body: some View {
        HStack {
            FavoriteButton(isFavourite: $task.isFavorite)
            HStack(spacing: 8) {
                Text(task.name)
                if (showProjectName) {
                    Spacer()
                    Text("(" + (task.project?.name ?? "") + ")")
                } else {
                    Spacer()
                }
            }
            .frame(maxWidth: .infinity)
            // .background(.orange)
        }
    }
}

#Preview {
    TaskView(showProjectName: true, task: .constant( Task("Task name", isFavorite: true)))
}
