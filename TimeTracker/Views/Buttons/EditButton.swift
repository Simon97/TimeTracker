//
//  EditButton.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 23/01/2024.
//

import SwiftUI

struct EditButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Label("Toggle editmode", systemImage: "pencil")
                .imageScale(.large)
                .labelStyle(.iconOnly)
                .padding(2)
        }
    }
}

#Preview {
    EditButton(action: {
        // do nothing in preview
    })
}
