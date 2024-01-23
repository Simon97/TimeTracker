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
    
    let modelContainer: ModelContainer
    
    // For some reason initializing this first makes the previews work (the TaskView preview
    // did not work previously)
    init() {
        do {
            modelContainer = try ModelContainer(for: Project.self)
        } catch {
            fatalError("Could not initialize ModelContainer")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(modelContainer)
    }
}
