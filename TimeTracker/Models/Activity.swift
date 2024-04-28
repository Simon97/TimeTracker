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
    
    init(_ name: String) {
        self.uuid = UUID()
        self.name = name
        self.timeRegistrations = []
    }
    
    func addTimeRegistration(timeRegistration: TimeRegistration) {
        timeRegistrations.append(timeRegistration)
    }
    
    static let sampleData = [
        Activity("Activity with a name"),
        Activity("Make release ready for App Store"),
        Activity("Implement Apple Pay as a payment option to some app"),
    ]
}
