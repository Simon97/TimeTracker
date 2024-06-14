//
//  BindingExtension.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 09/05/2024.
//

import Foundation
import SwiftUI

extension Binding {
    func withDefault<Wrapped>(value defaultValue: Wrapped) -> Binding<Wrapped> where Optional<Wrapped> == Value {
        Binding<Wrapped> {
            wrappedValue ?? defaultValue
        } set: { newValue in
            self.wrappedValue = newValue
        }
    }
}
