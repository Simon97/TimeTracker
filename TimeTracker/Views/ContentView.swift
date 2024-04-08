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
    
    // @State private var viewModel: ViewModel
    
    // @Query private var boards: [Board]
    
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
        
        var timeRegistrations: TimeRegistrationsList {
            var regs = [TimeRegistration]()
            for activity in boards[0].activities {
                for registration in activity.timeRegistrations {
                    regs.append(registration)
                }
            }
            return TimeRegistrationsList(timeRegistrations: regs)
        }
        
        init(boards: [Board]) {
            self.boards = boards
        }
    }
}

