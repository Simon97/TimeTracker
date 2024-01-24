//
//  TTTextFieldStyle.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 24/01/2024.
//

import SwiftUI

/**
 Modifier for textfields reuse  the style definition
 */
struct TTTextFieldStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            //.textFieldStyle(.roundedBorder)
    }
}

extension View {
    func ttTextStyle() -> some View {
        modifier(TTTextFieldStyle())
    }
}

#Preview {
    TextField("Hint", text: .constant("Input"))
}
