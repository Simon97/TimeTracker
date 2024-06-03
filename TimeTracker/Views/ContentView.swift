//
//  ContentView.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 16/01/2024.
//

import SwiftUI

enum Tab: String {
    case activities = "Activities"
    case timeRegistrations = "Time Registrations"
}

struct ContentView: View {
    @State private var selection: Tab = .activities
    
    var body: some View {
        TabView(selection: $selection) {
            ActivitiesTabView()
            TimeRegistrationsTab()
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(SampleData.shared.modelContainer)
}
