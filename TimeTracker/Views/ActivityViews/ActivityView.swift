//
//  ActivityView.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 29/03/2024.
//

import SwiftUI

struct ActivityView: View {
    
    @State private var viewModel: ViewModel
    init(
        activity: Activity,
        timeRegistrations: [TimeRegistration],
        deleteActivity: @escaping () -> Void) {
            self.viewModel = ViewModel(
                activity: activity,
                timeRegistrations: timeRegistrations,
                deleteActivity: deleteActivity
            )
        }
    // @Bindable var activity: Activity
    
    var body: some View {
        VStack {
            HStack {
                Text(viewModel.activity.name)
                Spacer()
                FavoriteButton(isFavourite: $viewModel.activity.isFavorite)
                DeleteButton(action: viewModel.deleteActivity)
            }
            
            /*
             ForEach(viewModel.activity.timeRegistrations) { reg in
             TimeRegistrationView(timeRegistration: reg)
             }
             */
        }
        .onTapGesture(perform: {
            viewModel.addTimeRegistration()
        })
    }
}

#Preview {
    ActivityView(
        activity: Activity("a1"),
        timeRegistrations: [], deleteActivity: {}
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
