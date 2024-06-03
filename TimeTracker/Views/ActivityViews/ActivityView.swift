//
//  ActivityView.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 29/03/2024.
//

import Combine
import SwiftUI

struct ActivityView: View {
    
    let editModeEnabled: Bool
    
    @Bindable var activity: Activity
    let isSelected: Bool
    var deleteActivity: () -> Void
    
    @Environment(\.dismiss) var dismiss
    
    @State private var showEditView = false
    
    init(activity: Activity,
         isSelected: Bool = false,
         editModeEnabled: Bool,
         deleteActivity: @escaping () -> Void) {
        self.activity = activity
        self.isSelected = isSelected
        self.editModeEnabled = editModeEnabled
        self.deleteActivity = deleteActivity
    }
    
    var body: some View {
        HStack {
            HStack {
                Text(activity.name)
                Spacer()
            }
            .padding(
                EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
            )
            .background(isSelected ? .orange : .clear)
            .cornerRadius(15)
            
            HStack {
                if editModeEnabled {
                    Button(action: {
                        showEditView = true
                    }) {
                        Image(systemName: "pencil")
                            .foregroundStyle(.teal)
                    }
                } else {
                    FavoriteButton(isFavourite: $activity.isFavorite)
                }
            }
            .frame(maxWidth: 25)
                        
            .alert("Rename activity", isPresented: $showEditView) {
                SaveTextDialog(input: $activity.name, title: "Name of activity")
            } message: {
                Text("Update the name of the activity")
            }
        }
    }
}

#Preview {
    ActivityView(
        activity: SampleData.shared.activity,
        editModeEnabled: false,
        deleteActivity: {}
    )
}

#Preview("Selected activity") {
    ActivityView(
        activity: SampleData.shared.activity,
        isSelected: true,
        editModeEnabled: false,
        deleteActivity: {}
    )
}

#Preview("Editable") {
    ActivityView(
        activity: SampleData.shared.activity,
        editModeEnabled: true,
        deleteActivity: {}
    )
}
