//
//  ToolbarItems.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 08/06/2024.
//

import SwiftUI

struct ActivityListToolbarItems: View {
    
    @Bindable var viewModel: ActivityListViewModel
    
    var body: some View {
        Button(action: {
            viewModel.editMode.toggle()
        }) {
            Text(viewModel.editMode ? "Done" : "Edit")
        }
        Button(action: {
            viewModel.showNewActivityView = true
        }) {
            Image(systemName: "plus")
        }
    }
}
