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
    
    @State private var viewModel = ViewModel()
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    
    var filteredActivities: [Activity] {
        activities.filter { activity in
            (!viewModel.showFavoritesOnly || activity.isFavorite)
        }
    }
    
    var body: some View {
        
        // TODO: Add a no activities view to show if there are no activities
        
        VStack {
            List {
                Toggle(isOn: $viewModel.showFavoritesOnly) {
                    Text("Show only favorites")
                }
                .tint(.teal)
                
                ForEach(filteredActivities, id: \.uuid) { activity in
                    ActivityView(
                        activity: activity,
                        isSelected: TimeRegistrationController().currentActivity(timeRegistrations)?.uuid == activity.uuid,
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
                .buttonStyle(PlainButtonStyle()) // disabling the action when pressing on each cell in the list
            }
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        viewModel.editMode.toggle()
                    }) {
                        Text(viewModel.editMode ? "Done" : "Edit")
                    }
                }
                
                ToolbarItem {
                    Button(action: {
                        viewModel.showNewActivityView = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .tint(.teal)
            .navigationTitle("Activities")
            
            let newActivityNameBinding = Binding(
                get: { viewModel.newActivity.name },
                set: {
                    viewModel.newActivity.name = $0
                    modelContext.insert(viewModel.newActivity)
                    viewModel.newActivity.name = ""
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
    }
    
    private func startTracking(activity: Activity) {
        let controller = TimeRegistrationController()
        let now = Date.now
        
        // If a tracking is ongoing, we end it by adding the end time, before creating the new registration
        if let ongoingTracking: TimeRegistration = controller.newestTimeRegistrationInList(timeRegistrations) {
            ongoingTracking.endTime = now
        }
        modelContext.insert(TimeRegistration(startTime: now, activity: activity))
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(activities[index])
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

extension ActivityList {
    
    @Observable
    class ViewModel {
        var showFavoritesOnly = false
        var showNewActivityView = false
        var newActivity: Activity = Activity("")
        
        var editMode = false
    }
}
