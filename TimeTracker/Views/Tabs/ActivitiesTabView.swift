//
//  ActivitiesTabView.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 14/02/2024.
//

import SwiftUI

/**
 Grid to show all activities ...
 */

struct ActivitiesTabView: View {
        
    @State private var viewModel: ViewModel
    init(board: Board, timeRegistrations: ObservedTimeRegistrations) {
        self.viewModel = ViewModel(board: board, timeRegistrations: timeRegistrations)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                BoardView(
                    board: viewModel.board,
                    timeRegistrations: viewModel.timeRegistrations
                )
            }
            .navigationTitle("Activities")
        }
        .tabItem {
            Label("Activities", systemImage: "list.bullet")
        }
        .tag(Tab.activities)
    }
}

/*
#Preview {
    ActivitiesTabView(
        board: Board(activities: [
            Activity("Activity 1", isFavorite: false),
            Activity("Activity 2", isFavorite: true),
            Activity("Activity 3", isFavorite: false),
            Activity("Activity with a very long an interesting name", isFavorite: false),
        ])
    )
}
*/

extension ActivitiesTabView {
    
    @Observable
    class ViewModel {
        
        var board: Board
        var timeRegistrations: ObservedTimeRegistrations
        
        init(board: Board, timeRegistrations: ObservedTimeRegistrations) {
            self.board = board
            self.timeRegistrations = timeRegistrations
        }
    }
    
}
