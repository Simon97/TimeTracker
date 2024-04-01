//
//  BoardView.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 29/03/2024.
//

import SwiftUI

struct BoardView: View {
    
    @Bindable var board: Board
    
    @Environment(\.dismiss) var dismiss
    
    @State private var showFavoritesOnly = false
    @State private var newActivity: Activity = Activity("", isFavorite: false)
    @State private var showCreateEditView = false
    
    var filteredActivities: [Activity] {
        board.activities.filter { activity in
            (!showFavoritesOnly || activity.isFavorite)
        }
    }
    
    var body: some View {
        
        // This is temporarily made as a simple list ...
        List {
            Button(action: {
                showCreateEditView = true
            }, label: {
                Text("Add activity")
            })
            .buttonStyle(BorderedButtonStyle())
            
            Toggle(isOn: $showFavoritesOnly) {
                Text("Show only favorites")
            }
            
            ForEach(filteredActivities, id: \.uuid) { activity in
                ActivityView(activity: activity)
            }
        }
        .buttonStyle(PlainButtonStyle()) // disabling the action when pressing on each cell in the list
        
        .alert("New activity", isPresented: $showCreateEditView) {
            TextField("Name", text: $newActivity.name)
            
            Button(action: {
                board.activities.append(newActivity)
                newActivity = Activity("", isFavorite: false) // making a new activity ready ...
                dismiss()
            }) {Text("Save")}
            
            Button(action: {
                dismiss()
            }) {Text("Cancel")}
            
        } message: {
            Text("Please the name of the new activity")
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
