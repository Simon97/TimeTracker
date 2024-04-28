//
//  ActivitiesTabView.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 14/02/2024.
//

import SwiftUI

/**
 Grid to show all activities ... Initially made as a list ...
 */

struct ActivitiesTabView: View {
    
    var body: some View {
        NavigationStack {
            VStack {
                BoardView()
                
                TrackingControllerView()
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
    ActivitiesTabView()
        .modelContainer(SampleData.shared.modelContainer)
}

extension ActivitiesTabView {
    
    @Observable
    class ViewModel {
        
        var board: Board
        var timeRegistrations: [TimeRegistration]
        
        init(board: Board, timeRegistrations: [TimeRegistration]) {
            self.board = board
            self.timeRegistrations = timeRegistrations
        }
    }
    
}
