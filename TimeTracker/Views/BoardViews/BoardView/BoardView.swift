//
//  BoardView.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 29/03/2024.
//

import SwiftUI
import SwiftData
import Observation
import Combine

struct BoardView: View {
    
    @State private var viewModel = ViewModel()
    
    @Query(sort: \Activity.name) private var activities: [Activity]
    @Query private var timeRegistrations: [TimeRegistration]
    
    @State private var newActivity: Activity = Activity("")
    
    @Environment(\.modelContext) private var modelContext
    
    @Environment(\.dismiss) var dismiss
    
    var filteredActivities: [Activity] {
        activities.filter { activity in
            (!viewModel.showFavoritesOnly || activity.isFavorite)
        }
    }
    
    func addTimeRegistration(activity: Activity) {
        let controller = TimeRegistrationController()
        let now = Date.now
        
        // If a tracking is ongoing, we end it by adding the end time, before adding the new registration
        if let ongoingTracking: TimeRegistration = controller.newestTimeRegistrationInList(timeRegistrations) {
            ongoingTracking.endTime = now
        }
        modelContext.insert(TimeRegistration(startTime: now, activity: activity))
    }
    
    var body: some View {
        
        // TODO: Add a no activities view to show if there are no activities yet, or if  all are deleted
        
        VStack {
            List {
                Toggle(isOn: $viewModel.showFavoritesOnly) {
                    Text("Show only favorites")
                }
                
                ForEach(filteredActivities, id: \.uuid) { activity in
                    ActivityView(
                        activity: activity,
                        isSelected: TimeRegistrationController().currentActivity(timeRegistrations)?.uuid == activity.uuid,
                        deleteActivity: {
                            modelContext.delete(activity)
                        }
                    )
                    .onTapGesture(perform: {
                        addTimeRegistration(activity: activity)
                    })
                }
                .onDelete(perform: deleteItems)
                .buttonStyle(PlainButtonStyle()) // disabling the action when pressing on each cell in the list
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                        .foregroundStyle(.teal)
                }
                
                ToolbarItem {
                    Button(action: {
                        viewModel.showCreateEditView = true
                    }) {
                        Image(systemName: "plus")
                            .foregroundStyle(.teal)
                    }
                    
                }
            }
            .navigationTitle("Activities")
            .alert("New activity", isPresented: $viewModel.showCreateEditView) {
                TextField("Name of activity", text: $newActivity.name)
                    .onReceive(Just(newActivity.name), perform: { _ in
                        let limit = 50
                        if newActivity.name.count > limit {
                            newActivity.name = String(newActivity.name.prefix(limit))
                        }
                    })
                
                
                Button(action: {
                    // TODO: Disable if the name is still empty
                    
                    // If "show only favorites is enabled, the newly added activity will be a favorite"
                    newActivity.isFavorite = viewModel.showFavoritesOnly
                    
                    // Trimming, just in case the user added a space in the end
                    newActivity.name = newActivity.name.trimmingCharacters(in: .whitespacesAndNewlines)
                    
                    modelContext.insert(newActivity)
                    dismiss()
                    newActivity = Activity("") // making ready for next activity
                }) {Text("Save")}
                    .disabled(newActivity.name.isEmpty)
                
                Button(action: {
                    dismiss()
                }) {
                    Text("Cancel")
                }
                
            } message: {
                // TODO: Change this, if the input limit is reached
                Text("Please write the name of the new activity")
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(activities[index])
            }
        }
    }
    
}


#Preview {
    NavigationStack {
        BoardView()
            .modelContainer(SampleData.shared.modelContainer)
    }
}

