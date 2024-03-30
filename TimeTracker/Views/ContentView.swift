//
//  ContentView.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 16/01/2024.
//

import SwiftData
import SwiftUI

enum Tab {
    case favorites
    case activities
    case timeRegistrations
}

struct ContentView: View {
    
    @Environment(\.modelContext) var modelContext
    @AppStorage("hasBeenOpenedBefore") private var hasBeenOpenedBefore = false
    
    @State private var selection: Tab = .activities
    
    @Query private var boards: [Board]

    /*
    private var registrations: TimeRegistrationsViewModel {
        var registrations = [TimeRegistration]()
        for task in tasks {
            registrations.append(contentsOf: task.timeRegistrations)
        }
        TimeRegistrationController().sortByDate(&registrations)
        return TimeRegistrationsViewModel(registrations: registrations)
    }
    */
    
    var body: some View {
        TabView(selection: $selection) {
            ActivitiesTabView(activitiesViewModel: ActivitiesViewModel(activities: boards[0].activities))
            // TimeRegistrationsTab(projects: projects, timeRegistrations: registrations)
        }
        
        .background(.black)
        .onAppear {
            if !hasBeenOpenedBefore {
                selection = .activities
                // addDemoProject()
                hasBeenOpenedBefore = true
            }
        }
    }
}

#Preview {
    ContentView()
}
