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
    
    // TODO: All this logic should be moved
    
    private let controller = TimeRegistrationController()
    
    var currentActivityName: String? {
        currentTimeRegistration?.activity?.name
    }
    
    var isTracking: Bool {
        if let currentTimeRegistration {
            return currentTimeRegistration.endTime == nil
        } else {
            return false
        }
    }
    
    func playButtonAction() {
        if isTracking {
            pauseTracking()
        } else {
            resumeTracking()
        }
    }
    
    var currentTimeRegistration: TimeRegistration? {
        let reg = controller.newestTimeRegistrationInList(timeRegistrations)
        print(
            "currentTimeRegistration is found",
            reg?.uuid ?? "",
            reg?.activity ?? ""
        )
        return reg
    }
    
    var timeSpendOnCurrentTaskToday: TimeInterval {
        return 0.0
    }
    
    
    private func pauseTracking() {
        print("Pausing")
        
        currentTimeRegistration?.endTime = .now
    }
    
    private func resumeTracking() {
        print("Resuming")
        
        
        if currentTimeRegistration!.activity != nil {
            let newRegistration = TimeRegistration(
                startTime: .now,
                activity: currentTimeRegistration!.activity!
            )
            modelContext.insert(newRegistration)
        }
        
    }
    
    var body: some View {
        HStack {
            VStack {
                Text(currentActivityName ?? "Pick an activity to start tracking")
                // Text("Time spend on task? Or time in total?")
            }
            
            Spacer()
            
            PlayPauseButton(isPlaying: isTracking,
                            action: playButtonAction
            )
            .disabled(currentTimeRegistration == nil)
            .frame(width: 42)
            
        }
        .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12))
    }
    
    
    // TODO: Move this function to another file
    func getStartDateForTimer(amountOfSeconds: Double) -> Date {
        
        // The start date is the current time minus the amount of time spend on the
        // project already. Then the timer will show the time spend increasing
        
        let timerStartTime = Calendar.current.date(
            // TODO: consider this weird convertion between Int and Double
            byAdding: .second, value: Int(-amountOfSeconds), to: .now
        )
        return timerStartTime ?? .now
    }
}

/*
#Preview(traits: .sizeThatFitsLayout) {
    TrackingControllerView(timeRegistrations: [])
        .modelContainer(SampleData.shared.modelContainer)
}
*/

extension TrackingControllerView {
    
    @Observable
    class ViewModel {
        
        private var timeRegistrations: [TimeRegistration]
        
        init(timeRegistrations: [TimeRegistration]) {
            self.timeRegistrations = timeRegistrations
        }
        
        private let controller = TimeRegistrationController()
        
        var currentActivityName: String? {
            currentTimeRegistration?.activity?.name
        }
        
        var isTracking: Bool {
            if let currentTimeRegistration {
                return currentTimeRegistration.endTime == nil
            } else {
                return false
            }
        }
        
        func playButtonAction() {
            if isTracking {
                pauseTracking()
            } else {
                resumeTracking()
            }
        }
        
        var currentTimeRegistration: TimeRegistration? {
            let reg = controller.newestTimeRegistrationInList(timeRegistrations)
            print(
                "currentTimeRegistration is found",
                reg?.uuid ?? "",
                reg?.activity ?? ""
            )
            return reg
        }
        
        var timeSpendOnCurrentTaskToday: TimeInterval {
            return 0.0
        }
        
        private func sort() {
            controller.sortByDate(&timeRegistrations)
        }
        
        private func pauseTracking() {
            print("Pausing")
            
            currentTimeRegistration?.endTime = .now
        }
        
        private func resumeTracking() {
            print("Resuming")
            
            
            if currentTimeRegistration!.activity != nil {
                let newRegistration = TimeRegistration(
                    startTime: .now,
                    activity: currentTimeRegistration!.activity!
                )
                
                timeRegistrations.append(newRegistration)
                sort()
            }
            
        }
        
    }
    
}
