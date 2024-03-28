//
//  ProjectTreeView.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 28/03/2024.
//

import SwiftUI

struct ProjectView: View {
    
    @Bindable var project: Project
    
    var body: some View {
        @Bindable var isCollapsedBinding = (
            project.presentationDetails ??
            ProjectPresentationDetails(isCollapsed: false)
        )
        
        VStack(alignment: .leading) {
            HStack {
                Text(project.name)
                    .font(.title)
                
                Spacer()
                
                if !project.subProjects.isEmpty {
                    CollapseSwitch(isCollapsed: $isCollapsedBinding.isCollapsed)
                }
            }
            
            if !isCollapsedBinding.isCollapsed {
                ForEach($project.subProjects, id: \.uuid) { $subProject in
                    ProjectView(project: subProject)
                        .padding(.leading)
                }
            }
            
        }
    }
}

#Preview("Collapsed", traits: .sizeThatFitsLayout) {
    ProjectView(
        project:
            Project("Project 1", parent: nil,
                    children: [
                        Project(
                            "Sub-project",
                            parent: nil,
                            children: [],
                            isCollapsed: true
                        )
                    ],
                    isCollapsed: true)
    )
}


#Preview("Non-collapsed", traits: .sizeThatFitsLayout) {
    ProjectView(
        project:
            Project("Project 1", parent: nil,
                    children: [
                        Project(
                            "Sub-project",
                            parent: nil,
                            children: [],
                            isCollapsed: false
                        )
                    ],
                    isCollapsed: false)
    )
}
