//
//  BoardView.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 29/03/2024.
//

import Combine
import SwiftUI
import SwiftData
import Observation

/**
 Grid to show all activities ... Initially made as a list ...
 */

struct BoardView: View {
    
    
    @Query(sort: \Activity.name) private var activities: [Activity]
    @Query private var timeRegistrations: [TimeRegistration]
    
    @State private var viewModel = ViewModel()
    @State private var newActivity: Activity = Activity("")
    
    @Environment(\.modelContext) private var modelContext
    //@Environment(\.editMode) private var editMode
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
                    .swipeActions() {
                        Button {
                            viewModel.showNewActivityView = true
                        } label: {
                            Label("Edit", systemImage: "pencil")
                        }
                        
                        
                        Button(role: .destructive) {
                            print("Delete...")
                        } label: {
                            Label("Delete", systemImage: "trash.fill")
                        }
                    }
                    .onTapGesture(perform: {
                        addTimeRegistration(activity: activity)
                    })
                }
                
                
                // .onDelete(perform: deleteItems)
                .buttonStyle(PlainButtonStyle()) // disabling the action when pressing on each cell in the list
            }
            .toolbar {
                /*
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                        .foregroundStyle(.teal)
                }
                */
                
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
            .alert("New activity", isPresented: $viewModel.showNewActivityView) {
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
    
    private func deleteActivity(_ activity: Activity) {
        withAnimation {
            modelContext.delete(activity)
        }
    }
    
}


#Preview {
    NavigationStack {
        BoardView()
            .modelContainer(SampleData.shared.modelContainer)
    }
}

extension BoardView {
    
    @Observable
    class ViewModel {
        var showFavoritesOnly = false
        var showNewActivityView = false
        var newActivity: Activity = Activity("")
        
        var editMode = false
    }
}
