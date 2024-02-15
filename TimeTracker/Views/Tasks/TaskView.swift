//
//  TaskView.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 19/01/2024.
//

import SwiftUI

struct TaskView: View {
    
    @Bindable var task: Task
    let showProjectName: Bool
    let selected: Bool = true
    
    var body: some View {
        Button(action: {
            let timeRegistration = TimeRegistration(
                startTime: .now,
                endTime: .now,
                task: task
            )
            task.timeRegistrations.append(timeRegistration)
        }) {
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
            }
        }
    }
}

#Preview {
    TaskView(task: Task("Task name", isFavorite: true), showProjectName: true)
}
