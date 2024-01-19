//
//  ExpandSwitch.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 14/01/2024.
//

import SwiftUI

struct ExpandSwitch: View {
    @Binding var isExpanded: Bool
    
    var body: some View {
        Button(action: {
            withAnimation() {
                isExpanded.toggle()
            }
        }, label: {
            Label("Expand",
                  systemImage: isExpanded ? "chevron.right.circle.fill" : "chevron.right.circle"
            )
            .imageScale(.large)
            .labelStyle(.iconOnly)
            .rotationEffect(.degrees(isExpanded ? 90 : 0))
            .padding(2)
        })
    }
}

struct ExpandSwitchPreview: View {
    @State private var isExpanded = false
    
    var body: some View {
        VStack {
            ExpandSwitch(isExpanded: $isExpanded)
            Text("Value: " + (isExpanded ? "Open" : "Closed"))
        }
    }
}

#Preview {
    ExpandSwitchPreview()
}