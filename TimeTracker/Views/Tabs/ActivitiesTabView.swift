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
    
    @Bindable var activitiesViewModel: ActivitiesViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                BoardView(activitiesViewModel: activitiesViewModel)
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
    ActivitiesTabView(activitiesViewModel: ActivitiesViewModel(activities: []))
}
