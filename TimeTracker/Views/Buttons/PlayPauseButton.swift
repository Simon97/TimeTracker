//
//  PlayPauseButton.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 17/02/2024.
//

import SwiftUI

struct PlayPauseButton: View {
    
    @Binding var isPlaying: Bool
    
    var body: some View {
        Button(action: {
            isPlaying.toggle()
        }, label: {
            Image(systemName: isPlaying ? "pause.circle" : "play.circle")
                .resizable()
                .scaledToFit()
        })
        .buttonStyle(.plain)
    }
}

#Preview("Playing") {
    PlayPauseButton(isPlaying: .constant(true))
        .padding()
}

#Preview("Paused/Stopped") {
    PlayPauseButton(isPlaying: .constant(false))
        .padding()
}
