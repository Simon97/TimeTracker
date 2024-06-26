//
//  ActivityView.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 29/03/2024.
//

import SwiftUI

struct ActivityView: View {
    
    let editModeEnabled: Bool
    
    @Bindable var activity: Activity
    let highlight: Bool
    var deleteActivity: () -> Void
    
    @Environment(\.dismiss) var dismiss
    
    @State private var showEditNameAlert = false
    
    init(activity: Activity,
         highlight: Bool = false,
         editModeEnabled: Bool,
         deleteActivity: @escaping () -> Void) {
        self.activity = activity
        self.highlight = highlight
        self.editModeEnabled = editModeEnabled
        self.deleteActivity = deleteActivity
    }
    
    var body: some View {
        HStack {
            Text(activity.name)
                .padding(8)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(highlight ? .orange : .clear)
                .cornerRadius(12)
                .contentShape(Rectangle())
            
            Group {
                if editModeEnabled {
                    Button(action: {
                        showEditNameAlert = true
                    }) {
                        Image(systemName: "pencil")
                            .foregroundStyle(.teal)
                    }
                    Button(action: {
                        deleteActivity()
                    }) {
                        Image(systemName: "trash")
                            .foregroundStyle(.teal)
                    }
                } else {
                    FavoriteButton(isFavourite: $activity.isFavorite)
                }
            }
            .frame(maxWidth: 20)
            
            EditTextDialog(
                showDialog: $showEditNameAlert,
                input: $activity.name,
                title: "Name of activity",
                message: "Edit activity name",
                inputLengthLimit: 50
            )
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

#Preview("Highlighted activity") {
    ActivityView(
        activity: SampleData.shared.activity,
        highlight: true,
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
