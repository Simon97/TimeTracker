//
//  BottomInfo.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 16/01/2024.
//

import SwiftUI
import SwiftData

struct TrackingControllerView: View {
    
    @Query var timeRegistrations: [TimeRegistration]
    @Environment(\.modelContext) private var modelContext
    
    @State private var isTracking = false
    
    init() {
        self.isTracking = self.currentTimeRegistration?.endTime == nil
    }
    
    var currentTimeRegistration: TimeRegistration? {
        let controller = TimeRegistrationController()
        return controller.newestTimeRegistrationInList(timeRegistrations)
    }
    
    var currentActivity: Activity? {
        currentTimeRegistration?.activity
    }
    
    var isPlaying: Bool {
        // This is a bit cryptic, but we need to consider that tracking can
        // be started by clicking on an activity on the list, which changes
        // the state without using the isTrackingBinding
        (currentTimeRegistration != nil &&
         currentTimeRegistration?.endTime == nil) || isTracking
    }
    
    func playButtonAction() {
        if isPlaying {
            pauseTracking()
        } else {
            resumeTracking()
        }
    }
    
    private func pauseTracking() {
        currentTimeRegistration?.endTime = .now
    }
    
    private func resumeTracking() {
        if currentTimeRegistration!.activity != nil {
            let newRegistration = TimeRegistration(
                startTime: .now,
                activity: currentTimeRegistration!.activity!
            )
            modelContext.insert(newRegistration)
        }
    }
    
    var body: some View {
        
        let isTrackingBinding = Binding(
            get: { self.isTracking || isPlaying },
            set: { val in
                playButtonAction()
                self.isTracking = val
            }
        )
        
        PlayerView(
            isPlaying: isTrackingBinding,
            nameOfPlayableItem:
                currentActivity?.name ?? "Pick an activity to start tracking",
            disabled: currentTimeRegistration == nil,
            amountOfSecondsPlayed: 22
        )
    }
}


#Preview(traits: .sizeThatFitsLayout) {
    TrackingControllerView()
        .modelContainer(SampleData.shared.modelContainer)
}
