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
    @State private var selection: Tab = .activities
    
    var body: some View {
        TabView(selection: $selection) {
            ActivitiesTabView()
            TimeRegistrationsTab()
        }
        .tint(.teal)
    }
}

#Preview {
    ContentView()
        .modelContainer(SampleData.shared.modelContainer)
}
