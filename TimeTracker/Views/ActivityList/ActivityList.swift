//
//  ActivityList.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 29/03/2024.
//

import SwiftUI
import SwiftData
import Observation

struct ActivityList: View {
    
    @Query(sort: \Activity.name) private var activities: [Activity]
    @Query private var timeRegistrations: [TimeRegistration]
    
    @State private var viewModel = ActivityListViewModel()
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    
    var filteredActivities: [Activity] {
        activities.filter { activity in
            (!viewModel.showFavoritesOnly || activity.isFavorite)
        }
    }
    
    var body: some View {
        Group {
            if activities.isEmpty {
                VStack {
                    Spacer()
                    Text("No activities")
                        .font(.title)
                        .bold()
                    Spacer()
                }
            } else {
                List {
                    Toggle(isOn: $viewModel.showFavoritesOnly) {
                        Text("Show only favorites")
                    }
                    .tint(.teal)
                    
                    ForEach(filteredActivities, id: \.uuid) { activity in
                        ActivityView(
                            activity: activity,
                            highlight: TimeRegistrationController()
                                .findLastAddedRegistration(timeRegistrations)?.activity == activity,
                            
                            editModeEnabled: viewModel.editMode,
                            deleteActivity: {
                                modelContext.delete(activity)
                            }
                        )
                        .onTapGesture(perform: {
                            startTracking(activity: activity)
                        })
                    }
                    .onDelete(perform: deleteItems)
                    .buttonStyle(PlainButtonStyle()) // disabling the default action when pressing on each cell in the list
                }
                .safeAreaPadding(EdgeInsets(top: 0, leading: 0, bottom: 100, trailing: 0))
            }
        }
        .toolbar {
            ActivityListToolbarItems(viewModel: viewModel)
        }
        .tint(.teal)
        .navigationTitle("Activities")
        
        let newActivityNameBinding = Binding(
            get: {
                viewModel.newActivity.name
            },
            set: {
                viewModel.newActivity.name = $0
                viewModel.newActivity.isFavorite = viewModel.showFavoritesOnly
                modelContext.insert(viewModel.newActivity)
                viewModel.newActivity = Activity("")
            }
        )
        
        EditTextDialog(
            showDialog: $viewModel.showNewActivityView,
            input: newActivityNameBinding,
            title: "New Activity",
            message: "Write name of new activity",
            inputLengthLimit: 50
        )
    }
    
    private func startTracking(activity: Activity) {
        let controller = TimeRegistrationController()
        let now = Date.now
        
        // We end the current registrations by adding the end time, before creating the new registration, unless the new one is the same as the old one
        if let onGoingTracking = controller.findLastAddedRegistration(timeRegistrations), controller.isRegistrationOnGoing(onGoingTracking) {
            
            if onGoingTracking.activity == activity {
                return
            }
            onGoingTracking.endTime = now
        }
        modelContext.insert(
            TimeRegistration(
                startTime: now,
                activity: activity
            )
        )
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(filteredActivities[index])
            }
        }
    }
    
    private func deleteActivity(_ activity: Activity) {
        withAnimation {
            modelContext.delete(activity)
        }
    }
    
}

#Preview {
    NavigationStack {
        ActivityList()
            .modelContainer(SampleData.shared.modelContainer)
    }
}

@Observable
class ActivityListViewModel {
    var showFavoritesOnly = false
    var showNewActivityView = false
    var newActivity: Activity = Activity("")
    var editMode = false
}

