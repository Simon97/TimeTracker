//
//  ProjectListView.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 28/03/2024.
//

import SwiftUI

struct ProjectListView: View {
    
    @Binding var projects: [RootProject]
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                ForEach(projects, id: \.uuid) { project in
                    ProjectView(project: project)
                    Divider()
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
        }
    }
}

#Preview {
    ProjectListView(
        projects: .constant([
            RootProject("Project 1", isOutermostProject: true, children: [
                RootProject("sub1", isOutermostProject: false, children: [], isCollapsed: true),
                RootProject("sub2", isOutermostProject: false, children: [
                    RootProject("subsub1", isOutermostProject: false, children: [], isCollapsed: true),
                    RootProject("subsub2", isOutermostProject: false, children: [], isCollapsed: true)
                ], isCollapsed: true)
            ], isCollapsed: true),
            RootProject("Project 2", isOutermostProject: true, children: [], isFavorite: true),
            RootProject("Project 3", isOutermostProject: true, children: [])
        ])
    )
}
