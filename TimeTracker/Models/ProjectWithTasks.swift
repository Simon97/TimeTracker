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
    var uuid: UUID
    
    var name: String
    
    var parent: Project
    
    @Relationship(deleteRule: .cascade, inverse: \ProjectWithTasks.parent)
    var children: [Project]
    
    var presentationDetails: ProjectPresentationDetails?
    
    init(_ name: String, parent: Project, children: [Project], presentationDetails: ProjectPresentationDetails? = nil) {
        self.uuid = UUID()
        self.name = name
        self.parent = parent
        self.children = children
        self.presentationDetails = presentationDetails
    }
}

/**
 This is the old Project data structure, which is supposed to be replaced by a new data model without tasks ...
*/
@Model
class ProjectWithTasks {
    @Attribute(.unique)
    var uuid: UUID
    
    var name: String
    var parent: ProjectWithTasks?
    var isOutermostProject: Bool
    
    @Relationship(deleteRule: .cascade, inverse: \ProjectWithTasks.parent)
    var subProjects: [ProjectWithTasks] = []
    
    @Relationship(deleteRule: .cascade)
    var tasks: [Task] = []
    
    var presentationDetails: ProjectPresentationDetails?
    
    
    init(_ name: String, isMainProject: Bool, isCollapsed: Bool?) {
        self.uuid = UUID()
        self.name = name
        self.isOutermostProject = isMainProject
        self.presentationDetails = ProjectPresentationDetails(isCollapsed: isCollapsed ?? false)
    }
    
    init(_ name: String, isMainProject: Bool, isCollapsed: Bool?, subProjects: [ProjectWithTasks], tasks: [Task]) {
        self.uuid = UUID()
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

extension ProjectWithTasks {
    public static func projectWithGeneralTask(isMainProject: Bool) -> ProjectWithTasks {
        let generalTask = Task("General", isFavorite: false)
        return ProjectWithTasks(
            "New project",
            isMainProject: isMainProject,
            isCollapsed: false,
            subProjects: [],
            tasks: [generalTask]
        )
    }
}

extension ProjectWithTasks {
    public static func addProjectWithDefaultTask(modelContext: ModelContext, name: String, isMainProject: Bool) {
        modelContext.insert(ProjectWithTasks(name, isMainProject: isMainProject, isCollapsed: false))
    }
}
