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
    
    @State private var selection: Tab = .activities
    
    @Query private var boards: [Board]
    
    @Query private var timeRegistrations: [TimeRegistration]
    
    private var timeRegistrationViewModel: TimeRegistrationsViewModel {
        // Maybe do some sorting first ...
        return TimeRegistrationsViewModel(registrations: timeRegistrations)
    }
    
    var body: some View {
        TabView(selection: $selection) {
            ActivitiesTabView(board: boards[0])
            TimeRegistrationsTab(timeRegistrations: timeRegistrationViewModel)
        }
        .background(.black)
    }
}

#Preview {
    ContentView()
}
