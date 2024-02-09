//
//  ContentView.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 16/01/2024.
//

import SwiftData
import SwiftUI

enum Tab {
    case favorites
    case allProjects
}

struct ContentView: View {
    
    @Environment(\.modelContext) var modelContext
        
    @Query(filter: #Predicate<Project> { project in
        project.isOutermostProject
    }) var projects: [Project]
    
    @State private var selection: Tab = .favorites
    
    private var tasks: [Task] {
        var tasks = [Task]()
        for project in projects {
            for task in project.getAllTasks() {
                tasks.append(task)
            }
        }
        return tasks
    }
    
    var body: some View {
        
        TabView(selection: $selection) {
            NavigationStack {
                VStack {
                    TaskListView(tasks: tasks)
                    
                    BottomInfo(
                        currentProject: "Some project",
                        secondsSpendTotalToday: 60 * 60 * 2 + 125,
                        secondsSpendOnCurrentProjectTotalToday: 60 * 60 * 3
                    )
                }
                .navigationTitle("Tasks")
            }
            .tabItem {
                Label("Tasks", systemImage: "star")
            }
            .tag(Tab.favorites)
            
            // ----
            
            NavigationStack {
                VStack {
                    ProjectList(projects: .constant(projects))
                }
                .navigationTitle("Projects")
                .toolbar {
                    Button("Add Demo") {
                        let project = Project(
                            "Preview Project",
                            isMainProject: true, isCollapsed: false,
                            subProjects: [
                                Project(
                                    "Sub project",
                                    isMainProject: false, isCollapsed: false,
                                    subProjects: [
                                        Project(
                                            "Sub sub project",
                                            isMainProject: false, isCollapsed: false,
                                            subProjects: [],
                                            tasks: [
                                                Task("sub sub project task 1", isFavorite: false)
                                            ]
                                        )],
                                    tasks: [
                                        Task("sub project task 1", isFavorite: false)
                                    ]
                                )
                            ],
                            tasks: [
                                Task("task 1", isFavorite: false),
                                Task("task 2", isFavorite: false)
                            ]
                        )
                        modelContext.insert(project)
                    }
                }
            }
            .tabItem {
                Label("Projects", systemImage: "list.bullet")
            }
            .tag(Tab.allProjects)
            
        }
    }
}

#Preview {
    ContentView()
}
