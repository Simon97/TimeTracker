//
//  Project.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 14/01/2024.
//

import Foundation
import SwiftData

@Model
class Project {
    @Attribute(.unique)
    var id: UUID
    
    var name: String
    var parent: Project?
    var isOutermostProject: Bool
    
    @Relationship(deleteRule: .cascade, inverse: \Project.parent)
    var subProjects: [Project] = []
    
    @Relationship(deleteRule: .cascade)
    var tasks: [Task] = []
    
    var presentationDetails: ProjectPresentationDetails
    
    
    init(_ name: String, isMainProject: Bool, isCollapsed: Bool?) {
        self.id = UUID()
        self.name = name
        self.isOutermostProject = isMainProject
        self.presentationDetails = ProjectPresentationDetails(isCollapsed: isCollapsed ?? false)
    }
    
    init(_ name: String, isMainProject: Bool, isCollapsed: Bool?, subProjects: [Project], tasks: [Task]) {
        self.id = UUID()
        self.name = name
        self.isOutermostProject = isMainProject
        self.subProjects = subProjects
        self.tasks = tasks
        self.presentationDetails = ProjectPresentationDetails(isCollapsed: isCollapsed ?? false)
    }
    
    func getAllTasks() -> [Task] {
        var _tasks = [Task]()
        _tasks = tasks
        for subProject in subProjects {
            for task in subProject.getAllTasks() {
                _tasks.append(task)
            }
        }
        return _tasks
    }
}

extension Project {
    public static func projectWithGeneralTask(isMainProject: Bool) -> Project {
        let generalTask = Task("General", isFavorite: false)
        return Project(
            "New project",
            isMainProject: isMainProject,
            isCollapsed: false,
            subProjects: [],
            tasks: [generalTask]
        )
    }
}

extension Project {
    public static func addProjectWithDefaultTask(modelContext: ModelContext, name: String, isMainProject: Bool) {
        modelContext.insert(Project(name, isMainProject: isMainProject, isCollapsed: false))
    }
}
