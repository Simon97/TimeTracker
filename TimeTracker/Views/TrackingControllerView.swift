//
//  BottomInfo.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 16/01/2024.
//

import SwiftUI

struct TrackingControllerView: View {
    
    @State private var viewModel: ViewModel
    init(timeRegistrations: ObservedTimeRegistrations) {
        self.viewModel = ViewModel(timeRegistrations: timeRegistrations)
    }
    
    var body: some View {
        HStack {
            VStack {
                Text(viewModel.currentActivityName ?? "Pick an activity to start tracking")
                // Text("Time spend on task? Or time in total?")
            }
            
            Spacer()
            
            PlayPauseButton(isPlaying: viewModel.isTracking,
                            action: viewModel.playButtonAction
            )
            .disabled(viewModel.currentTimeRegistration == nil)
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


#Preview(traits: .sizeThatFitsLayout) {
    TrackingControllerView(timeRegistrations: ObservedTimeRegistrations(timeRegistrations: []))
}


extension TrackingControllerView {
    
    @Observable
    class ViewModel {
        
        private(set) var timeRegistrations: ObservedTimeRegistrations
        
        private let controller = TimeRegistrationController()
        
        init(timeRegistrations: ObservedTimeRegistrations) {
            self.timeRegistrations = timeRegistrations
            sort()
        }
        
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
            // This should end the ongoing registration or create a new one depending
            // on if the tracking is ongoing or not ...
            
            if isTracking {
                pauseTracking()
            } else {
                resumeTracking()
            }
        }
        
        var currentTimeRegistration: TimeRegistration? {
            let reg = controller.newestTimeRegistrationInList(timeRegistrations.timeRegistrations)
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
            controller.sortByDate(&timeRegistrations.timeRegistrations)
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
                
                timeRegistrations.timeRegistrations.append(newRegistration)
                sort()
            }
            
        }
        
    }
    
}
