//
//  ProjectDetails.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 15/01/2024.
//

import SwiftUI

struct ProjectDetails: View {
    
    @Binding var project: Project
    var editModeEnabled: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            if (!project.tasks.isEmpty) {
                Text("Tasks:")
                    .font(.headline)
            }
            ForEach(project.tasks, id: \.self.name) { task in
                HStack() {
                    // The HStack and Spacer is needed to make the
                    // text be aligned even when no sub-projects are
                    // available
                    TaskView(showProjectName: false, task: .constant(task))
                    Spacer()
                }
            }
            Divider()
            if (!project.subProjects.isEmpty) {
                Text("Sub-projects:")
                    .font(.headline)
            }
            ForEach($project.subProjects, id: \.self.name) { project in
                ProjectView(project: project, editModeEnabled: editModeEnabled)
            }
            
        }
    }
}

#Preview {
    ProjectDetails(project: .constant(Project(
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
    )), editModeEnabled: false)
}
