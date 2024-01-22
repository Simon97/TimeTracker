//
//  ProjectList.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 14/01/2024.
//

import SwiftUI

struct ProjectView: View {
    
    var project: Project
    
    @State private var showDetails = false
    
    var body: some View {
        VStack {
            HStack {
                Text(project.name)
                    .font(.title)
                Spacer()
                ExpandSwitch(isExpanded: $showDetails)
            }
            if showDetails {
                ProjectDetails(project: project)
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

#Preview {
    ProjectView(
        project: previewProject
    )
}
