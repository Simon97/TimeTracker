//
//  ContentView.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 14/01/2024.
//

import SwiftUI

struct ProjectList: View {
    
    @Environment(\.modelContext) var modelContext
    
    @Binding var projects: [Project]
    
    @State private var editModeEnabled = false
    @State private var showCreateNewProject = false
    @State private var newProject = Project.projectWithGeneralTask(isMainProject: true)
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(projects) { project in
                    ProjectView(project: project, projects: $projects, editModeEnabled: editModeEnabled)
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
                newProject = Project.projectWithGeneralTask(isMainProject: true)
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
    ProjectList(projects: .constant([
        Project(
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
    ])
    )
}
