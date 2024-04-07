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
    
    // @Environment(\.modelContext) var modelContext
    
    @State private var selection: Tab = .activities
    
    // @Query private var boards: [Board]
    
    var boards: [Board]
    var timeRegistrations: ObservedTimeRegistrations
    
    init(boards: [Board], timeRegistrations: ObservedTimeRegistrations) {
        self.boards = boards
        self.timeRegistrations = timeRegistrations
    }
    
    
    var body: some View {
        
        // Currently, the registrations-tab is not updated when an activity is deleted.
        TabView(selection: $selection) {
            
            ActivitiesTabView(
                board: boards[0],
                timeRegistrations: timeRegistrations
            )
            
            TimeRegistrationsTab(
                timeRegistrations: timeRegistrations
            )
            
        }
        .background(.black)
    }
}

/*
 #Preview {
 ContentView()
 }
 */


extension ContentView {
    
    // Currently not in use
    class ViewModel {
        
        var boards: [Board]
        var timeRegistrations: ObservedTimeRegistrations // TODO: These should be found from boards in the constructor?
        
        init(boards: [Board], timeRegistrations: ObservedTimeRegistrations) {
            self.boards = boards
            self.timeRegistrations = timeRegistrations
        }
    }
}

