//
//  FavoriteButton.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 19/01/2024.
//

import SwiftUI

struct FavoriteButton: View {
    @Binding var isFavourite : Bool
    
    var body: some View {
        Button(action: {isFavourite.toggle()}) {
            Label("Toggle Favorite", systemImage: isFavourite ? "star.fill" : "star")
                .labelStyle(.iconOnly)
                .foregroundStyle(isFavourite ? .yellow : .gray)
        }
    }
}

#Preview {
    return FavoriteButtonPreviewWrapper()
}

/* Making a wrapper around the view with state, to make it react in the preview */
struct FavoriteButtonPreviewWrapper: View {
    @State private var isSetInitialTrue: Bool = true
    @State private var isSetInitialFalse: Bool = false
    
    var body: some View {
        Group {
            FavoriteButton(isFavourite: $isSetInitialTrue)
            FavoriteButton(isFavourite: $isSetInitialFalse)
        }
    }
}
