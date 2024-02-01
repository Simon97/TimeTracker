//
//  ProjectList.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 14/01/2024.
//

import SwiftUI

struct ProjectView: View {
    
    @Binding var project: Project
    
    var editModeEnabled: Bool
    @State private var showEditingView = false
    
    @State private var showDetails = false
    
    var body: some View {
        VStack {
            HStack {
                Text(project.name)
                    .font(.title)
                
                Spacer()
                
                if editModeEnabled {
                    EditButton(action: {
                        showEditingView.toggle()
                    })
                    .sheet(isPresented: $showEditingView) {
                        EditProjectView(project: project, type: .exsitingProject)
                    }
                } else {
                    ExpandSwitch(isExpanded: $showDetails)
                }
            }
            if showDetails {
                ProjectDetails(project: $project, editModeEnabled: editModeEnabled)
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

#Preview {
    ProjectView(
        project: .constant(Project(
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
        )
        ), editModeEnabled: false)
}
