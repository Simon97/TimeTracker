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
    
    var container: ModelContainer
    var descriptor: FetchDescriptor<Board>
    
    @AppStorage("hasBeenOpenedBefore") private var hasBeenOpenedBefore = false
    
    @Environment(\.modelContext) var modelContext
    
    init() {
        do {
            container = try ModelContainer(for: Board.self)
            descriptor = FetchDescriptor<Board>()
            
            if !hasBeenOpenedBefore {
                // Creates the default/general board
                container.mainContext.insert(Board(activities: []))
                try! container.mainContext.save()
                print("Default board created ...")
            }
            
        } catch {
            fatalError("Could not initialize ModelContainer")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(boards: try! container.mainContext.fetch(descriptor), timeRegistrations: [])
        }
        .modelContainer(container)
    }
}
