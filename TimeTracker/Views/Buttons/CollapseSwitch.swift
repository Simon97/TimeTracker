//
//  CollapseSwitch.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 14/01/2024.
//

import SwiftUI

struct CollapseSwitch: View {
    @Binding var isCollapsed: Bool
    
    var body: some View {
        Button(action: {
            withAnimation() {
                isCollapsed.toggle()
            }
        }) {
            Label("Expand",
                  systemImage: isCollapsed ? "chevron.right.circle" : "chevron.right.circle.fill"
            )
            .imageScale(.large)
            .labelStyle(.iconOnly)
            .rotationEffect(.degrees(isCollapsed ? 0 : 90))
            .padding(2)
        }
    }
}

struct ExpandSwitchPreview: View {
    @State private var isCollapsed = false
    
    var body: some View {
        VStack {
            CollapseSwitch(isCollapsed: $isCollapsed)
            Text("Value: " + (isCollapsed ? "Open" : "Closed"))
        }
    }
}

#Preview {
    ExpandSwitchPreview()
}
