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

extension ActivityView {
    
    @Observable
    class ViewModel {
        var activity: Activity
        var timeRegistrations: [TimeRegistration]
        var deleteActivity: () -> Void
        
        var controller = TimeRegistrationController()
        
        init(
            activity: Activity,
            timeRegistrations: [TimeRegistration],
            deleteActivity: @escaping () -> Void) {
                self.activity = activity
                self.timeRegistrations = timeRegistrations
                self.deleteActivity = deleteActivity
            }
        
        func addTimeRegistration() {
            let now = Date.now
            
            // If a tracking is ongoing, we end it before adding the new one for the new activity
            if let ongoingTracking: TimeRegistration = controller.newestTimeRegistrationInList(timeRegistrations) {
                ongoingTracking.endTime = now
            }
            
            timeRegistrations.append(
                TimeRegistration(startTime: now, activity: activity)
            )
        }
        
    }
    
}
