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
    case timeRegistrations
}

struct ContentView: View {
    
    @Environment(\.modelContext) var modelContext
    @AppStorage("hasBeenOpenedBefore") private var hasBeenOpenedBefore = false
    
    @State private var selection: Tab = .favorites
    
    @Query(filter: #Predicate<Project> { project in
        project.isOutermostProject
    }) var projects: [Project]
    
    private var tasks: [Task] {
        var tasks = [Task]()
        for project in projects {
            tasks.append(contentsOf: project.getAllTasks())
        }
        return tasks
    }
    
    private var registrations: [TimeRegistration] {
        var registrations = [TimeRegistration]()
        for task in tasks {
            registrations.append(contentsOf: task.timeRegistrations)
        }
        return registrations
    }
    
    var body: some View {
        TabView(selection: $selection) {
            TasksTab(tasks: tasks)
            ProjectTabView(projects: projects)
            TimeRegistrationsTab(timeRegistrations: registrations)
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
