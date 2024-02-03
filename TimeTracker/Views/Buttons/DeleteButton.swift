//
//  DeleteButton.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 03/02/2024.
//

import SwiftUI

struct DeleteButton: View {
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }) {
            Label("Delete", systemImage: "trash")
        }
        .labelStyle(.iconOnly)
    }
}

#Preview {
    DeleteButton(action: {
        // nothing in preview
    })
}
