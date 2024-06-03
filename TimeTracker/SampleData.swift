//
//  SampleData.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 27/04/2024.
//

import Foundation
import SwiftData

@MainActor
class SampleData {
    
    static let shared = SampleData()
    
    let modelContainer: ModelContainer
    
    var context: ModelContext {
        modelContainer.mainContext
    }
    
    var timeRegistrations: [TimeRegistration] = [
        TimeRegistration(startTime: .now, endTime: .now.addingTimeInterval(21500), activity: Activity.sampleData[1]),
        TimeRegistration(startTime: .now, endTime: .now.addingTimeInterval(7500), activity: Activity.sampleData[2]),
        TimeRegistration(startTime: .now, activity: Activity.sampleData[0])
    ]
    
    // Construct a list of TimeRegistrations ... ?
    
    var timeRegistrationOngoing: TimeRegistration {
        let timeReg = TimeRegistration(startTime: .now, activity: activity)
        return timeReg
    }
    
    var timeRegistrationCompleted: TimeRegistration {
        let timeReg = TimeRegistration(startTime: .now, activity: activity)
        timeReg.endTime = .now.addingTimeInterval(1234)
        return timeReg
    }
    
    private init() {
        let schema = Schema([
            Board.self,
            Activity.self,
            TimeRegistration.self
        ])
        
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        
        do {
            modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
            insertSampleData()
            
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
    
    func insertSampleData() {
        for activity in Activity.sampleData {
            context.insert(activity)
        }
        
        do {
            try context.save()
        } catch {
            print("Sample data context failed to save.")
        }
    }
    
    var activity: Activity {
        Activity.sampleData[3]
    }
    
    var activityWithLongName: Activity {
        Activity.sampleData[2]
    }
}
