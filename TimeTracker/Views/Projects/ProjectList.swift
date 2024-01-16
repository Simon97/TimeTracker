//
//  ContentView.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 14/01/2024.
//

import SwiftUI

struct ProjectList: View {
    var body: some View {
        ScrollView {
            LazyVStack {
                ProjectView(project: previewProject)
                    .buttonStyle(.plain)
                ProjectView(project: previewProject2)
                    .buttonStyle(.plain)
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding()
        }
    }
}

#Preview {
    ProjectList()
}
