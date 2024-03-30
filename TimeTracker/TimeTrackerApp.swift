//
//  TimeTrackerApp.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 14/01/2024.
//

import SwiftData
import SwiftUI

@main
struct TimeTrackerApp: App {
    
    let projectContainer: ModelContainer
    
    init() {
        do {
            projectContainer = try ModelContainer(for: Activity.self, Board.self, TimeRegistration.self)
            
            // Creates the default/general board
            projectContainer.mainContext.insert(Board(activities: []))
            try! projectContainer.mainContext.save()
            
        } catch {
            fatalError("Could not initialize ModelContainer")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(projectContainer)
    }
}
