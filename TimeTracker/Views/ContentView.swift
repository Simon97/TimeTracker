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
    case projects
}

struct ContentView: View {
    
    @Environment(\.modelContext) var modelContext
    @AppStorage("firstTimeOpened") private var hasBeenOpenedBefore = false
    
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
                        addDemoProject()
                    }
                }
            }
            .tabItem {
                Label("Projects", systemImage: "list.bullet")
            }
            .tag(Tab.projects)
            
        }
        .onAppear {
            /**
             The first time the app is opened, we add and show a demo project in the projects tab
             */
            if !hasBeenOpenedBefore {
                selection = .projects
                addDemoProject()
                hasBeenOpenedBefore = true
            }
        }
    }
    
    func addDemoProject() {
        let project = Project(
            "Preview Project",
            isMainProject: true, isCollapsed: false,
            subProjects: [
                Project(
                    "Sub project",
                    isMainProject: false,
                    isCollapsed: false,
                    subProjects: [
                        Project(
                            "Sub sub project",
                            isMainProject: false,
                            isCollapsed: false,
                            subProjects: [],
                            tasks: [
                                Task("sub sub project task 1", isFavorite: true)
                            ]
                        )],
                    tasks: [
                        Task("sub project task 1", isFavorite: false)
                    ]
                )
            ],
            tasks: [
                Task("task 1", isFavorite: true),
                Task("task 2", isFavorite: false)
            ]
        )
        modelContext.insert(project)
    }
}

#Preview {
    ContentView()
}
