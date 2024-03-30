//
//  Board.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 29/03/2024.
//

import Foundation
import SwiftData

@Model
class Board {
    
    @Attribute(.unique)
    var uuid: UUID
    
    var activities: [Activity]
    
    init(activities: [Activity]) {
        self.uuid = UUID()
        self.activities = activities
    }
}
