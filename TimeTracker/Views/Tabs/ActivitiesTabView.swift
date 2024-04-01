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
    
    @Bindable var board: Board // It might make more sense not to depend on a Board here in Activities tab ...
    
    var body: some View {
        NavigationStack {
            VStack {
                BoardView(board: board)
                
                BottomInfo(timeRegistrations: TimeRegistrationsViewModel(registrations: []))
            }
            .navigationTitle("Activities")
        }
        .tabItem {
            Label("Activities", systemImage: "list.bullet")
        }
        .tag(Tab.activities)
    }
}

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
