//
//  BoardView.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 29/03/2024.
//

import SwiftUI

struct BoardView: View {
    
    @State private var showFavoritesOnly = false
    
    @Bindable var activitiesViewModel: ActivitiesViewModel
    
    var filteredActivities: [Activity] {
        activitiesViewModel.activities.filter { activity in
            (!showFavoritesOnly || activity.isFavorite)
        }
    }
    
    var body: some View {
        // This is temporarily made as a simple list ...
        List {
            Toggle(isOn: $showFavoritesOnly) {
                Text("Show only favorites")
            }
            
            ForEach(filteredActivities, id: \.uuid) { activity in
                ActivityView(activity: activity)
            }
            Button(action: {
                // TODO: instead of this, we should open a modal where the user can write the name for the new activity
                activitiesViewModel.activities.append(Activity("new activity", isFavorite: false))
            }, label: {
                Text("Add activity")
            })
        }
        .buttonStyle(PlainButtonStyle()) // disabling the action when pressing on each cell in the list
    }
    
}

#Preview {
    BoardView(activitiesViewModel: ActivitiesViewModel(activities: [
        Activity("Activity 1", isFavorite: false),
        Activity("Activity 2", isFavorite: true),
        Activity("Activity 3", isFavorite: false),
        Activity("Activity with a very long an interesting name", isFavorite: false),
    ]))
}
