//
//  ContentView.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 14/01/2024.
//

import SwiftUI

struct ProjectList: View {
    var projects: [Project]
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(projects) { project in
                    ProjectView(project: project)
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding()
        }
    }
}

#Preview {
    ProjectList(projects: [Project(
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
    ), Project(
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
    )])
}
