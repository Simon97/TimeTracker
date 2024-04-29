//
//  PlayPauseButton.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 17/02/2024.
//

import SwiftUI

struct PlayPauseButton: View {
    
    var isPlaying: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action, label: {
            Image(systemName: isPlaying ? "pause.circle" : "play.circle")
                .resizable()
                .scaledToFit()
        })
        .buttonStyle(.plain)
    }
}

#Preview("Playing") {
    PlayPauseButton(isPlaying: true, action: {})
        .padding()
}

#Preview("Paused/Stopped") {
    PlayPauseButton(isPlaying: false, action: {})
        .padding()
}
