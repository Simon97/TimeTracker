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
    
    let controller = TimeRegistrationController()
    
    var isTrackingOnGoing: Bool {
        controller.isRegistrationOnGoing(timeRegistrations: timeRegistrations)
    }
    
    var latestActivity: Activity? {
        controller.findLastAddedRegistration(timeRegistrations)?.activity
    }
    
    var secondsSpendOnCurrentActivity: TimeInterval {
        if latestActivity == nil {
            return 0
        }
        
        let controller = TimeRegistrationController()
        return controller.timeSpendOnActivityonDate(
            timeRegistrations,
            activity: latestActivity!,
            date: .now
        )
    }
    
    var body: some View {
        
        let isTrackingBinding = Binding(
            get: { isTrackingOnGoing },
            set: { _ in
                playButtonAction()
            }
        )
        
        PlayerView(
            isPlaying: isTrackingBinding,
            nameOfPlayableItem:
                latestActivity?.name ?? "Pick an activity to start tracking",
            disabled: latestActivity == nil,
            amountOfSecondsPlayed: secondsSpendOnCurrentActivity
        )
    }
    
    func playButtonAction() {
        if isTrackingOnGoing {
            pauseTracking()
        } else {
            resumeTracking()
        }
    }
    
    private func pauseTracking() {
        controller.pauseTracking(timeRegistrations: timeRegistrations)
    }
    
    private func resumeTracking() {
        controller.resumeTracking(
            timeRegistrations: timeRegistrations,
            modelContext: modelContext
        )
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    TrackingControllerView()
        .modelContainer(SampleData.shared.modelContainer)
        .padding()
}
