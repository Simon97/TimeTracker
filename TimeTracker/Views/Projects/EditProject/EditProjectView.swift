//
//  EditProjectView.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 24/01/2024.
//

import SwiftUI

struct EditProjectView: View {
    
    @Binding var project: Project
    
    var body: some View {
        Text("Edit \(project.name)")
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
