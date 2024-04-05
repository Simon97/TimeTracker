//
//  BoardView.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 29/03/2024.
//

import SwiftUI
import Observation

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
