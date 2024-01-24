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
    var subProjects: [Project] = []
    
    @Relationship(deleteRule: .cascade)
    var tasks: [Task] = []
    
    var isOutermostProject: Bool
    
    // Parental relationship
    @Relationship(deleteRule:.cascade, inverse: \Project.parent) var children: [Project]?
    public var parent: Project?
    
    
    init(_ name: String, isMainProject: Bool) {
        self.id = UUID()
        self.name = name
        self.isOutermostProject = isMainProject
    }
    
    init(_ name: String, isMainProject: Bool, subProjects: [Project], tasks: [Task]) {
        self.id = UUID()
        self.name = name
        self.isOutermostProject = isMainProject
        self.subProjects = subProjects
        self.tasks = tasks
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
