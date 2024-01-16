//
//  Project.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 14/01/2024.
//

import Foundation

@Observable
class Project {
    var name: String
    var subProjects: [Project] = []
    var tasks: [Task] = []
    
    init(_ name: String) {
        self.name = name
    }
    
    init(_ name: String, subProjects: [Project], tasks: [Task]) {
        self.name = name
        self.subProjects = subProjects
        self.tasks = tasks
    }
}
