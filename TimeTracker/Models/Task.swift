//
//  Task.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 14/01/2024.
//

import Foundation
import SwiftData

@Model
class Task {
    @Attribute(.unique)
    var id: UUID
    var name: String
    var isFavorite: Bool
    
    @Relationship(inverse: \Project.tasks)
    var project: Project?
    
    init(_ name: String, isFavorite: Bool) {
        self.id = UUID()
        self.name = name
        self.isFavorite = isFavorite
    }
}
