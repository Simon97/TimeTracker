//
//  Activity.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 14/01/2024.
//

import Foundation
import SwiftData

@Model
class Activity {
    
    @Attribute(.unique)
    var uuid: UUID

    var name: String
    
    var isFavorite = false
        
    @Relationship(deleteRule: .cascade, inverse: \TimeRegistration.activity)
    var timeRegistrations: [TimeRegistration]
    
    var board: Board?
    
    init(_ name: String, isFavorite: Bool = false) {
        self.uuid = UUID()
        self.name = name
        self.isFavorite = isFavorite
        self.timeRegistrations = []
    }
    
    func addTimeRegistration(timeRegistration: TimeRegistration) {
        timeRegistrations.append(timeRegistration)
    }
    
    static let sampleData = [
        Activity("Activity with a name"),
        Activity("Make release ready for App Store", isFavorite: true),
        Activity("Implement Apple Pay as a payment option to some app"),
        Activity("Add LiveActivity for TimeTracker app"),
        Activity("Add LiveWidget for TimeTracker, to show how many hours spend on top 3/5 tasks, and maybe the total time"),
    ]
}
