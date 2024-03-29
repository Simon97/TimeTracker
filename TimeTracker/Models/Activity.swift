//
//  Activity.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 14/01/2024.
//

import Foundation
import Observation
import SwiftData

@Observable
class Activity {
    
    @Attribute(.unique)
    var uuid: UUID

    var name: String
    
    var isFavorite: Bool
    
    init(uuid: UUID, name: String, isFavorite: Bool) {
        self.uuid = uuid
        self.name = name
        self.isFavorite = isFavorite
    }
}


/**
 This is the root of a project tree, containing instances of Subproject
 */
@Observable
class RootProject {
    @Attribute(.unique)
    var uuid: UUID
    
    var name: String
    
    var isFavorite: Bool
    
    var parent: RootProject?
    
    var isOutermostProject: Bool
    
    @Relationship(deleteRule: .cascade, inverse: \RootProject.parent)
    var subProjects: [RootProject]
    
    var presentationDetails: ProjectPresentationDetails?
    
    init(_ name: String, isOutermostProject: Bool, children: [RootProject], isCollapsed: Bool? = nil, isFavorite: Bool? = nil) {
        self.uuid = UUID()
        self.name = name
        self.subProjects = children
        self.isOutermostProject = isOutermostProject
        self.presentationDetails = ProjectPresentationDetails(isCollapsed: isCollapsed ?? false)
        self.isFavorite = isFavorite ?? false
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
