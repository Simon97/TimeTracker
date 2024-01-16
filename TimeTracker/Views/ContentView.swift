//
//  ContentView.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 16/01/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ProjectList()
                .navigationTitle("Time Tracker")
        }
    }
}

#Preview {
    ContentView()
}
