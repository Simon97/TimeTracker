//
//  Task.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 14/01/2024.
//

import Foundation
import SwiftData

@Model
class Task: Equatable {
    @Attribute(.unique) var uuid: UUID
    var name: String
    var isFavorite: Bool
    var project: Project?
    
    init(_ name: String, isFavorite: Bool) {
        self.uuid = UUID()
        self.name = name
        self.isFavorite = isFavorite
    }
}
