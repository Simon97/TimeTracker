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
        .background(.black)
    }
}

// Add Sample data class for this ...
/*
 #Preview {
 ContentView()
 }
 */


extension ContentView {
    
    @Observable
    class ViewModel {
        
        var boards: [Board]
        
        var timeRegistrations: [TimeRegistration] {
            var regs = [TimeRegistration]()
            for activity in boards[0].activities {
                for registration in activity.timeRegistrations {
                    regs.append(registration)
                }
            }
            return regs
        }
        
        init(boards: [Board]) {
            self.boards = boards
        }
    }
}

