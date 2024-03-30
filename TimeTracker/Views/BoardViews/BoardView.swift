//
//  BoardView.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 29/03/2024.
//

import SwiftUI

struct BoardView: View {
    
    @State private var showFavoritesOnly = false
    
    @State private var newActivity: Activity = Activity("", isFavorite: false)
    @State private var showCreateEditView = false
    
    @Bindable var board: Board
    
    var filteredActivities: [Activity] {
        board.activities.filter { activity in
            (!showFavoritesOnly || activity.isFavorite)
        }
    }
    
    var body: some View {
        VStack {
            // This is temporarily made as a simple list ...
            List {
                Toggle(isOn: $showFavoritesOnly) {
                    Text("Show only favorites")
                }
                
                ForEach(filteredActivities, id: \.uuid) { activity in
                    ActivityView(activity: activity)
                }
            }
            .buttonStyle(PlainButtonStyle()) // disabling the action when pressing on each cell in the list
            
            Button(action: {
                // TODO: instead of this, we should open a modal where the user can write the name for the new activity
                print("Doing something")
                showCreateEditView = true
            }, label: {
                Text("Add activity")
            })
        }
        .sheet(isPresented: $showCreateEditView) {
            CreateEditActivityView(activity: newActivity, saveAction: {
                board.activities.append(newActivity)
            })
        }
    }
    
}

#Preview {
    BoardView(board: Board(activities: [
        Activity("Activity 1", isFavorite: false),
        Activity("Activity 2", isFavorite: true),
        Activity("Activity 3", isFavorite: false),
        Activity("Activity with a very long an interesting name", isFavorite: false),
    ]))
}
