//
//  ProjectDetails.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 15/01/2024.
//

import SwiftUI

struct ProjectDetails: View {
    
    var project: Project
    
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
                    TaskView(task: .constant(task))
                    Spacer()
                }
            }
            Divider()
            if (!project.subProjects.isEmpty) {
                Text("Sub-projects:")
                    .font(.headline)
            }
            ForEach(project.subProjects, id: \.self.name) { project in
                ProjectView(project: project)
            }
            
        }
    }
}

#Preview {
    ProjectDetails(project: previewProject)
}
