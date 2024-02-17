//
//  PlayPauseButton.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 17/02/2024.
//

import SwiftUI

enum PlayPauseButtonState {
    case playing
    case paused
    case disabled
}

struct PlayPauseButton: View {
    var state: PlayPauseButtonState
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }, label: {
            Image(systemName: state == .paused ? "pause.circle" : "play.circle")
                .resizable()
                .scaledToFit()
        })
        .buttonStyle(PlainButtonStyle())
        .disabled(state == .disabled)
    }
}

#Preview {
    VStack {
        PlayPauseButton(state: .playing, action: {})
        PlayPauseButton(state: .paused, action: {})
        PlayPauseButton(state: .disabled, action: {})
    }
}
