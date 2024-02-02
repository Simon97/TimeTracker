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

// TODO: Make this an editView in the sense that it only keeps the changes if some save button is pressed ...
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
                    text: $project.name
                )
                .ttTextStyle()
                .focused($nameFocus)
            }
            
            Section("Tasks") {
                VStack {
                    ForEach(project.tasks) { task in
                        @Bindable var task = task
                        HStack {
                            TextField(
                                "Task name",
                                text: $task.name
                            )
                            .ttTextStyle()
                            
                            Button(action: {
                                print("Running button action")
                                
                                /*
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
                                */
                                
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
                    project.tasks.append(Task("Task", isFavorite: false))
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
