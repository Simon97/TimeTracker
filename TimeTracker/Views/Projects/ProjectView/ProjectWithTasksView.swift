//
//  ProjectList.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 14/01/2024.
//

import SwiftUI

struct ProjectWithTasksView: View {
    
    @Environment(\.modelContext) var modelContext
    @Bindable var project: ProjectWithTasks
    @Binding var subProjects: [ProjectWithTasks]
    
    var editModeEnabled: Bool
    @State private var showEditingView = false
    @State private var showDeleteAlert = false
    
    var body: some View {
        VStack {
            @Bindable var isCollapsedBinding =
            (project.presentationDetails ?? ProjectPresentationDetails(isCollapsed: false))
            
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
                            showDeleteAlert = true
                        })
                    }
                    .alert("This will delete the project and all associated tasks and sub-projects",
                           isPresented: $showDeleteAlert) {
                        Button("Delete", role: .destructive) {
                            if project.isOutermostProject {
                                modelContext.delete(project)
                                // TODO: Do proper error handling ...
                                try? modelContext.save()
                            } else {
                                var indexToRemove: Int? {
                                    subProjects.firstIndex(where: { p in
                                        p.uuid == project.uuid
                                    })
                                }
                                if let index = indexToRemove {
                                    subProjects.remove(at: index)
                                }
                            }
                        }
                    }
                           .sheet(isPresented: $showEditingView) {
                               EditProjectView(project: project, type: .exsitingProject)
                           }
                } else {
                    CollapseSwitch(isCollapsed: $isCollapsedBinding.isCollapsed)
                }
            }
            if !isCollapsedBinding.isCollapsed {
                ProjectDetails(project: project, editModeEnabled: editModeEnabled)
            }
            
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

#Preview {
    ProjectWithTasksView(
        project: ProjectWithTasks(
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
        ), subProjects: .constant([]), editModeEnabled: false)
}
