//
//  Board.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 29/03/2024.
//

import Foundation
import SwiftData

/**
 * The idea is to make it possible to group activities on different boards. One for each customer/project for example.
 * Then we can show time tracked for all activities on the same board.
 *
 * It is called a Board since I imagine some kind of drag and drop of activities to different boards
 */

@Model
class Board {
    
    @Attribute(.unique)
    var uuid: UUID
    
    var name: String
    
    @Relationship(deleteRule: .cascade, inverse: \Activity.board)
    private(set) var activities: [Activity]
        
    init(name: String, activities: [Activity]) {
        self.uuid = UUID()
        self.name = name
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
    
}
