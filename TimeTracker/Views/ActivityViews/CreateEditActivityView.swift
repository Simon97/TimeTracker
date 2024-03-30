//
//  CreateEditActivityView.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 30/03/2024.
//

import SwiftUI

struct CreateEditActivityView: View {
    
    @Environment(\.dismiss) var dismiss
    @Bindable var activity: Activity
    var saveAction: () -> Void
    
    var body: some View {
        VStack {
            Text("Create activity")
            
            TextField(text: $activity.name) {
                Text("Name")
            }
            .padding()
            
            Button(action: {
                saveAction()
                dismiss()
            }) {
                Text("Save")
            }
        }
    }
}

#Preview {
    CreateEditActivityView(
        activity: Activity(
            "Test",
            isFavorite: false
        ), saveAction: {}
    )
}
