//
//  ProjectsTabView.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 14/02/2024.
//

import SwiftUI

struct ProjectTabView: View {
    
    var projects: [ProjectWithTasks]
    
    var body: some View {
        NavigationStack {
            VStack {
                ProjectList(projects: .constant(projects))
            }
            .navigationTitle("Projects")
        }
        .tabItem {
            Label("Projects", systemImage: "list.bullet")
        }
        .tag(Tab.projects)
    }
}

#Preview {
    ProjectTabView(projects: [])
}
