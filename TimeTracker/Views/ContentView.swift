//
//  ContentView.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 16/01/2024.
//

import SwiftUI

enum Tab {
    case favorites
    case allProjects
}

struct ContentView: View {
    
    @State private var selection: Tab = .favorites
    
    var body: some View {
        
        TabView(selection: $selection) {
            NavigationStack {
                VStack {
                    Text("Hej")
                        .frame(maxHeight: .infinity)
                    BottomInfo(
                        currentProject: "Some project",
                        secondsSpendTotalToday: 60 * 60 * 2 + 125,
                        secondsSpendOnCurrentProjectTotalToday: 60 * 60 * 3
                    )
                }
                .navigationTitle("Favorites")
            }
            .tabItem {
                Label("Favorites", systemImage: "star")
            }
            .tag(Tab.favorites)
            
            // ----
            
            NavigationStack {
                VStack {
                    ProjectList()
                }
                .navigationTitle("All projects")
            }
            .tabItem {
                Label("All Projects", systemImage: "list.bullet")
            }
            .tag(Tab.allProjects)
        }
    }
}

#Preview {
    ContentView()
}
