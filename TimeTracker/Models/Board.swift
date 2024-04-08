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
    
    // TODO: It might make sense to add a name
    
    @Relationship(deleteRule: .cascade, inverse: \Activity.board)
    private(set) var activities: [Activity]
    
    var sortedActivities: [Activity] {
        sortActivities()
        return activities
    }
    
    init(activities: [Activity]) {
        self.uuid = UUID()
        self.activities = activities
    }
    
    func addActivity(_ activity: Activity) {
        activities.append(activity)
    }
    
    func removeActivity(_ activity: Activity) {
        activities.removeAll(where: { a in
            a.uuid == activity.uuid
        })
    }
        
    func sortActivities() {
        activities.sort(by: {
            a1, a2 in
            a1.name > a2.name
        })
    }
}
