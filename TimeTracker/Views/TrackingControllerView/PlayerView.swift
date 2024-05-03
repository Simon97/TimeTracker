//
//  PlayerView.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 03/05/2024.
//

import SwiftUI

struct PlayerView: View {
    
    @Binding var isPlaying: Bool
    
    var nameOfPlayableItem: String
    var disabled: Bool
    var amountOfSecondsPlayed: TimeInterval
    
    var formattedTime: String {
        let controller = TimeRegistrationController()
        let interval = amountOfSecondsPlayed
        return controller.formatToTime(amountOfSeconds: interval)
    }
    
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading) {
                Text(nameOfPlayableItem)
                    .lineLimit(2)
                
                Divider()
                
                if isPlaying {
                    Text(getStartDateForTimer(amountOfSeconds: amountOfSecondsPlayed), style: .timer)
                } else {
                    Text(formattedTime)
                }
            }
            
            Spacer()
            
            PlayPauseButton(isPlaying: self.$isPlaying)
                .disabled(self.disabled)
                .frame(width: 42)
                .padding()
            
        }
        .padding(EdgeInsets(top: 6, leading: 12, bottom: 6, trailing: 12))
        .frame(maxWidth: .infinity)
        .background {
            Color.teal
        }
        .cornerRadius(15)
    }
    
    func getStartDateForTimer(amountOfSeconds: Double) -> Date {
        /**
         The start date is the current time minus the amount of seconds spend on the item already.
         Then the timer will show the time spend increasing
         */
        let timerStartTime = Calendar.current.date(
            byAdding: .second, value: Int(-amountOfSeconds), to: .now
        )
        return timerStartTime ?? .now
    }
}

#Preview("Playing") {
    PlayerView(
        isPlaying: .constant(true),
        nameOfPlayableItem: "Like a Rolling Stone",
        disabled: false,
        amountOfSecondsPlayed: 22
    )
}

#Preview("Paused/Stopped") {
    PlayerView(
        isPlaying: .constant(false),
        nameOfPlayableItem: "Like a Rolling Stone",
        disabled: false,
        amountOfSecondsPlayed: 22
    )
}
