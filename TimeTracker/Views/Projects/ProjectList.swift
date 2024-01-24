//
//  ContentView.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 14/01/2024.
//

import SwiftUI

struct ProjectList: View {
    @Binding var projects: [Project]
    
    @State private var editModeEnabled = false
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach($projects) { project in
                    ProjectView(project: project, editModeEnabled: editModeEnabled)
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding()
        }
        .toolbar {
            Button("Edit") {
                editModeEnabled.toggle()
                // switch to edit mode
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
