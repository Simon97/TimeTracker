//
//  BoardView.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 29/03/2024.
//

import SwiftUI

struct BoardView: View {
    
    // This is just an attempt to use ViewModel instead of Board directly
    @State private var viewModel: ViewModel
    init(board: Board) {
        self.viewModel = ViewModel(board: board)
    }
    // @Bindable var board: Board
    
    @Environment(\.dismiss) var dismiss
        
    
    var body: some View {
        
        // This is temporarily made as a simple list ...
        List {
            Button(action: {
                viewModel.showCreateEditView = true
            }, label: {
                Text("Add activity")
            })
            .buttonStyle(BorderedButtonStyle())
            
            Toggle(isOn: $viewModel.showFavoritesOnly) {
                Text("Show only favorites")
            }
            
            ForEach(viewModel.filteredActivities, id: \.uuid) { activity in
                ActivityView(activity: activity)
            }
        }
        .buttonStyle(PlainButtonStyle()) // disabling the action when pressing on each cell in the list
        
        .alert("New activity", isPresented: $viewModel.showCreateEditView) {
            TextField("Name", text: $viewModel.newActivity.name)
            
            Button(action: {
                viewModel.saveNewTask()
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

extension BoardView {
    
    @Observable
    class ViewModel {
        
        var board: Board
        var showFavoritesOnly = false
        var showCreateEditView = false
        var newActivity: Activity = Activity("", isFavorite: false)
        
        init(board: Board) {
            self.board = board
        }
        
        var filteredActivities: [Activity] {
            board.activities.filter { activity in
                (!showFavoritesOnly || activity.isFavorite)
            }
        }
        
        func saveNewTask() {
            // if we only show favorites, the new activity will be an activity as well
            newActivity.isFavorite = showFavoritesOnly
            
            board.activities.append(newActivity)
            newActivity = Activity("", isFavorite: false) // making a new activity ready ...
        }
    }
}
