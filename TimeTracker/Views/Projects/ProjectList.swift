//
//  ContentView.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 14/01/2024.
//

import SwiftUI

struct ProjectList: View {
    var projects: [Project]
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(projects) { project in
                    ProjectView(project: project)
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding()
        }
    }
}

#Preview {
    ProjectList(projects: [previewProject, previewProject])
}
