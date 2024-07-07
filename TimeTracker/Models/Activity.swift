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
    
    // Keep in mind that the lenght of the names are blocked to 50 characters
    static let sampleData = [
        Activity("Activity with a name"),
        Activity("Make release ready for App Store", isFavorite: true),
        Activity("LiveActivity to play and pause from homescreen"),
        Activity("LiveWidget to show time spend on top activities"),
        Activity("One of many"),
        Activity("One of many"),
        Activity("One of many"),
        Activity("One of many"),
        Activity("One of many"),
        Activity("One of many"),
        Activity("One of many"),
        Activity("One of many"),
        Activity("One of many"),
        Activity("One of many"),
        Activity("One of many"),
        Activity("One of many"),
        Activity("One of many"),
        Activity("One of many"),
    ]
}
