//
//  ContentView.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 14/01/2024.
//

import SwiftUI

struct ProjectWithTaskList: View {
    
    @Environment(\.modelContext) var modelContext
    
    @Binding var projects: [ProjectWithTasks]
    
    @State private var editModeEnabled = false
    @State private var showCreateNewProject = false
    @State private var newProject = ProjectWithTasks.projectWithGeneralTask(isMainProject: true)
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(projects) { project in
                    ProjectWithTasksView(project: project, subProjects: $projects, editModeEnabled: editModeEnabled)
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding()
        }
        .sheet(isPresented: $showCreateNewProject) {
            EditProjectView(project: newProject, type: .newProject)
        }
        .toolbar {
            Button(action: {
                newProject = ProjectWithTasks.projectWithGeneralTask(isMainProject: true)
                modelContext.insert(newProject)
                showCreateNewProject.toggle()
            }, label: {Text("Add")})
            
            Button(editModeEnabled ? "Done" : "Edit") {
                editModeEnabled.toggle()
            }
        }
    }
}

#Preview {
    ProjectWithTaskList(projects: .constant([
        ProjectWithTasks(
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
    ])
    )
}
