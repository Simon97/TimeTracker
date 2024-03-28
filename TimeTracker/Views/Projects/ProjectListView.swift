//
//  ProjectListView.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 28/03/2024.
//

import SwiftUI

struct ProjectListView: View {
    
    @Binding var projects: [Project]
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                ForEach(projects, id: \.uuid) { project in
                    ProjectView(project: project)
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
        }
    }
}

#Preview {
    ProjectListView(
        projects: .constant([
            Project("Project 1", parent: nil, children: [
                Project("sub1", parent: nil, children: [], isCollapsed: true),
                Project("sub2", parent: nil, children: [], isCollapsed: true)
            ], isCollapsed: true),
            Project("Project 2", parent: nil, children: [], isCollapsed: true),
            Project("Project 3", parent: nil, children: [], isCollapsed: true)
        ])
    )
}
