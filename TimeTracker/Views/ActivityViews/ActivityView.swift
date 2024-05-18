//
//  ActivityView.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 29/03/2024.
//

import SwiftUI

struct ActivityView: View {
        
    @Bindable var activity: Activity
    let isSelected: Bool
    var deleteActivity: () -> Void
    
    init(activity: Activity,
         isSelected: Bool = false,
         deleteActivity: @escaping () -> Void) {
        self.activity = activity
        self.isSelected = isSelected
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
            
            FavoriteButton(isFavourite: $activity.isFavorite)
            
            // This is removed for now, since it can be deleted from the list
            // DeleteButton(action: deleteActivity)
        }
    }
}

#Preview {
    ActivityView(
        activity: SampleData.shared.activity,
        deleteActivity: {}
    )
}

#Preview("Selected activity") {
    ActivityView(
        activity: SampleData.shared.activity,
        isSelected: true,
        deleteActivity: {}
    )
}
