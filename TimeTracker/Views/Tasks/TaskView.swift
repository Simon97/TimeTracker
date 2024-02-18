//
//  TaskView.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 19/01/2024.
//

import SwiftUI

struct TaskView: View {
    
    /**
     This specifies if the taskview should create new time-registrations or not
     */
    var isTaskSelector: Bool
    
    @Bindable var task: Task
    var timeRegistrations: TimeRegistrationsViewModel?
    
    let showProjectName: Bool
    
    var body: some View {
        if !isTaskSelector {
            content
        } else {
            Button(action: {
                let timeRegistration = TimeRegistration(
                    startTime: .now,
                    task: task
                )
                timeRegistrations?.currentTimeRegistration?.endTime = .now
                task.timeRegistrations.append(timeRegistration)
            })
            {content}
                .buttonStyle(.plain)
        }
    }
    
    var content: some View {
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
        .padding(EdgeInsets(top: 8, leading: 4, bottom: 8, trailing: 4))
        .background(timeRegistrations?.currentTask == task ? Color.orange : Color.clear)
        .cornerRadius(10)
    }
}

#Preview {
    TaskView(
        isTaskSelector: true, task: Task("Task name", isFavorite: true),
        timeRegistrations: TimeRegistrationsViewModel(registrations: []),
        showProjectName: true
    )
}
