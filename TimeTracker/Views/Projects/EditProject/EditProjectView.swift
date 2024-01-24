//
//  EditProjectView.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 24/01/2024.
//

import SwiftUI

struct EditProjectView: View {
    
    @Binding var project: Project
    @FocusState private var nameFocus
    
    var body: some View {
        Form {
            Text("Edit")
                .font(.title)
            
            
            Section {
                TextField(
                    "Project title",
                    text: Binding(projectedValue:$project.name))
                .ttTextStyle()
                .focused($nameFocus)
            }
            
            Section {
                ForEach($project.tasks) { task in
                    HStack {
                        TextField(
                            "Task name",
                            text: Binding(projectedValue: task.name)
                        )
                        .ttTextStyle()
                        
                        Button(action: {
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
                Button(action: {
                    project.tasks.append(Task("Task", isFavorite: false))
                    // try? project.modelContext?.save()
                }) {
                    Label("Add task", systemImage: "plus")
                }
                .labelStyle(.iconOnly)
            }
            .onAppear(perform: {
                nameFocus = true
            })
        }
        .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8 ))
    }
}

#Preview {
    EditProjectView(project: .constant(Project(
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
    )))
}
