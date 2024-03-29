//
//  ProjectTreeView.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 28/03/2024.
//

import SwiftUI

struct ProjectView: View {
    
    @Bindable var project: RootProject
    
    var body: some View {
        @Bindable var isCollapsedBinding = (
            project.presentationDetails ??
            ProjectPresentationDetails(isCollapsed: false)
        )
        
        VStack(alignment: .leading) {
            HStack {
                Text(project.name)
                    .font(.title2)
                
                FavoriteButton(isFavourite: $project.isFavorite)
                
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
            RootProject("Project 1", isOutermostProject: true,
                    children: [
                        RootProject(
                            "Sub-project", isOutermostProject: false,
                            children: [],
                            isCollapsed: true
                        )
                    ],
                    isCollapsed: true)
    )
}


#Preview("Non-collapsed", traits: .sizeThatFitsLayout) {
    ProjectView(project:
                    RootProject("Project 1", isOutermostProject: true,
                            children: [
                                RootProject(
                                    "Sub-project", isOutermostProject: false,
                                    children: [],
                                    isCollapsed: false
                                )
                            ], isFavorite: true))
}
