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
    
    @State private var viewModel: ViewModel
    init(boards: [Board]) {
        self.viewModel = ViewModel(boards: boards)
    }
    
    var body: some View {
        TabView(selection: $selection) {
            
            ActivitiesTabView(
                board: viewModel.boards[0],
                timeRegistrations: viewModel.timeRegistrations
            )
            
            TimeRegistrationsTab(
                timeRegistrations: viewModel.timeRegistrations
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

