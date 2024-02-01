//
//  EditProjectView.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 24/01/2024.
//

import SwiftUI

enum EditProjectViewType {
    case newProject
    case exsitingProject
}

struct EditProjectView: View {
    
    @Bindable var project: Project
    @FocusState private var nameFocus
    
    @Environment(\.dismiss) var dismiss
    
    var type: EditProjectViewType
    
    var body: some View {
        Form {
            Text("\(type == .exsitingProject ? "Edit" : "Create") project")
                .font(.title)
            
            Section {
                TextField(
                    "Project title",
                    text: Binding(projectedValue:$project.name))
                .ttTextStyle()
                .focused($nameFocus)
            }
            
            Section("Tasks") {
                VStack {
                    ForEach($project.tasks) { task in
                        HStack {
                            TextField(
                                "Task name",
                                text: Binding(projectedValue: task.name)
                            )
                            .ttTextStyle()
                            
                            Button(action: {
                                print(project.tasks)
                                if let index = project.tasks.firstIndex(where: { t in
                                    t.id == task.id
                                }) {
                                    project.tasks.remove(at: index)
                                }
                            }) {
                                Label("Delete", systemImage: "trash")
                            }
                            .labelStyle(.iconOnly)
                        }
                    }
                    if (project.tasks.isEmpty) {
                        Text("No tasks in this project")
                    }
                }
            }
            
            Section {
                Button(action: {
                    let newTask = Task("Task", isFavorite: false)
                    project.tasks.append(newTask)
                }) {
                    Label("Add task", systemImage: "plus")
                }
            }
            
            Section {
                Button(action: {
                    dismiss()
                }) {
                    Text("Close")
                }
            }
        }
        .onAppear(perform: {
            nameFocus = true
        })
        .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8 ))
    }
}

#Preview {
    EditProjectView(
        project: Project(
            "Preview Project",
            isMainProject: true,
            subProjects: [
                Project(
                    "Sub project",
                    isMainProject: false,
                    subProjects: [
                        Project(
                            "Sub sub project",
                            isMainProject: false,
                            subProjects: [],
                            tasks: [
                                Task("sub sub project task 1", isFavorite: false)
                            ]
                        )],
                    tasks: [
                        Task("sub project task 1", isFavorite: false)
                    ]
                )
            ],
            tasks: [
                Task("task 1", isFavorite: false),
                Task("task 2", isFavorite: false)
            ]
        ),
        type: .newProject
    )
}
