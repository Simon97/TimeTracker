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
    
    @Bindable var project: ProjectWithTasks
    
    @FocusState private var nameFocus
    @Environment(\.dismiss) var dismiss
    
    var type: EditProjectViewType
    
    var body: some View {
        NavigationStack {
            ScrollView {
                HStack {
                    Text("Project name:")
                        .font(.headline)
                    
                    TextField(
                        "Project title",
                        text: $project.name,
                        axis: .vertical
                    )
                    .ttTextStyle()
                    .focused($nameFocus)
                    .textFieldStyle(.roundedBorder)
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 24, trailing: 0))
                
                VStack {
                    HStack {
                        Text("Tasks")
                            .font(.headline)
                        
                        Button(action: {
                            // Making sure that the tasks are named differently
                            project.tasks.append(Task("Task \(project.tasks.count + 1)", isFavorite: false))
                        }) {
                            Label("Add task", systemImage: "plus.circle")
                                .labelStyle(.iconOnly)
                        }
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    
                    ForEach(project.tasks) { task in
                        @Bindable var task = task
                        HStack {
                            TextField(
                                "Task name",
                                text: $task.name,
                                axis: .vertical
                            )
                            .ttTextStyle()

                            DeleteButton(action: {
                                var indexToRemove: Int? {
                                    project.tasks.firstIndex(where: { t in
                                        t.uuid == task.uuid
                                    })
                                }
                                if let index = indexToRemove {
                                    print("Deleting task with uuid: \(project.tasks[index].uuid)")
                                    print("Deleting index \(index)")
                                    project.tasks.remove(at: index)
                                }
                            }
                            )
                        }
                    }
                    if (project.tasks.isEmpty) {
                        Text("No tasks in this project")
                    }
                }
                
                Spacer()
                
                Button(action: {
                    dismiss()
                }) {
                    Text("Close")
                }
                .buttonStyle(.bordered)
            }
            .navigationTitle("\(type == .exsitingProject ? "Edit" : "Create") project")
            .onAppear(perform: {
                nameFocus = true
            })
            .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8 ))
        }
    }
}

#Preview {
    EditProjectView(
        project: ProjectWithTasks(
            "Preview Project",
            isMainProject: true, isCollapsed: false,
            subProjects: [
                ProjectWithTasks(
                    "Sub project",
                    isMainProject: false, isCollapsed: false,
                    subProjects: [
                        ProjectWithTasks(
                            "Sub sub project",
                            isMainProject: false, isCollapsed: false,
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
