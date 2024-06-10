//
//  FavoriteButton.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 19/01/2024.
//

import SwiftUI

struct FavoriteButton: View {
    
    @Binding var isFavourite : Bool
    
    @State private var animationAmount: Double
    
    init(isFavourite: Binding<Bool>) {
        self._isFavourite = isFavourite
        
        // Ensuring that all the buttons rotate in the same direction when turned on or off, regardless
        // of whether they are initialized as favorites or not.
        self.animationAmount = isFavourite.wrappedValue ? 180.0 : 0.0
    }
    
    var body: some View {
        Button {
            withAnimation {
                isFavourite.toggle()
                animationAmount = animationAmount == 0 ? 180 : 0
            }
        } label: {
            Image(systemName: isFavourite ? "star.fill" : "star")
                .resizable()
                .scaledToFit()
                .foregroundStyle(isFavourite ? .yellow : .gray)
        }
        .rotation3DEffect(
            .degrees(animationAmount),
            axis: (x: 0, y: 1, z: 0)
        )
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    FavoriteButtonPreviewWrapper()
        .padding()
}

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
