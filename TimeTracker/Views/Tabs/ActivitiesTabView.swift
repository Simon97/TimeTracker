//
//  ActivitiesTabView.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 14/02/2024.
//

import SwiftUI

struct ActivitiesTabView: View {
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                ActivityList()
                
                TrackingControllerView()
                    .padding(
                        EdgeInsets(
                            top: 0,
                            leading: 6,
                            bottom: 0,
                            trailing: 6)
                    )
                    .offset(y: -16)
            }
            .navigationTitle("Activities")
        }
        .tabItem {
            Label(Tab.activities.rawValue, systemImage: "list.bullet").foregroundStyle(Color.teal)
        }
        .tag(Tab.activities)
    }
}


#Preview {
    ActivitiesTabView()
        .modelContainer(SampleData.shared.modelContainer)
}
