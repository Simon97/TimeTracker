//
//  ToggleButton.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 19/01/2024.
//

import SwiftUI

struct ToggleView<FalseView: View, TrueView: View>: View {
    
    @Binding var binding: Bool
    
    @ViewBuilder let falseContent: () -> FalseView
    @ViewBuilder let trueContent: () -> TrueView
    
    var body: some View {
        if binding {
            trueContent()
        } else {
            falseContent()
        }
    }
}

#Preview("true") {
    ToggleView(
        binding: .constant(true),
        falseContent: {Text("false")},
        trueContent: {Text("true")}
    )
}

#Preview("false") {
    ToggleView(
        binding: .constant(false),
        falseContent: {Text("false")},
        trueContent: {Text("true")}
    )
}
