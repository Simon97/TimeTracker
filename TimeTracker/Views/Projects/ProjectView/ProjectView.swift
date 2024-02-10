//
//  ProjectList.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 14/01/2024.
//

import SwiftUI

struct ProjectView: View {
    
    @Environment(\.modelContext) var modelContext
    @Bindable var project: Project
    @Binding var projects: [Project]
    
    var editModeEnabled: Bool
    @State private var showEditingView = false
    
    var body: some View {
        VStack {
            HStack {
                Text(project.name)
                    .font(.title)
                
                Spacer()
                
                if editModeEnabled {
                    HStack(spacing: 12) {
                        EditButton(action: {
                            showEditingView.toggle()
                        })
                        DeleteButton(action: {
                            // Show a confirm dialog since a lot of stuff will be deleted by this operation
                            
                            print("Number of projects in list we look at:", projects.count)
                            
                            if project.isOutermostProject {
                                modelContext.delete(project)
                                // TODO: Do proper error handling ...
                                try? modelContext.save()
                            } else {
                                var indexToRemove: Int? {
                                    projects.firstIndex(where: { p in
                                        p.uuid == project.uuid
                                    })
                                }
                                if let index = indexToRemove {
                                    projects.remove(at: index)
                                }
                            }
                        })
                    }
                    .sheet(isPresented: $showEditingView) {
                        EditProjectView(project: project, type: .exsitingProject)
                    }
                } else {
                    @Bindable var isCollapsedBinding = project.presentationDetails
                    ExpandSwitch(isExpanded: $isCollapsedBinding.isCollapsed)
                }
            }
            if project.presentationDetails.isCollapsed {
                ProjectDetails(project: project, editModeEnabled: editModeEnabled)
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

#Preview {
    ProjectView(
        project: Project(
            "Preview Project",
            isMainProject: true, isCollapsed: false,
            subProjects: [
                Project(
                    "Sub project",
                    isMainProject: false, isCollapsed: false,
                    subProjects: [
                        Project(
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
        ), projects: .constant([]), editModeEnabled: false)
}
