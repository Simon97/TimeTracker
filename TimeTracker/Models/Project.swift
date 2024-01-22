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
    var name: String
    var subProjects: [Project] = []
    
    @Relationship(deleteRule: .cascade)
    var tasks: [Task] = []
    
    var isMainProject: Bool
    
    // Parental relationship
    public var parent: Project?
    @Relationship(deleteRule:.cascade, inverse: \Project.parent) var children: [Project]?
    
    
    init(_ name: String, isMainProject: Bool) {
        self.name = name
        self.isMainProject = isMainProject
    }
    
    init(_ name: String, isMainProject: Bool, subProjects: [Project], tasks: [Task]) {
        self.name = name
        self.isMainProject = isMainProject
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
