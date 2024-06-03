//
//  SaveTextDialog.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 01/06/2024.
//

import Combine
import SwiftUI
import Observation

/**
 * View to be shown in alerts
 * Title with a Textfield
 * Possible input max-length
 * Save and Cancel button. The dialog works on a copy, and only changes the Binding, if save is pressed
 */

struct SaveTextDialog: View {
    
    @Binding var input: String
    
    let title: String
    let inputLengthLimit: Int
    
    @Environment(\.dismiss) var dismiss
    
    @State private var viewState: ViewState
    
    init(input: Binding<String>, title: String, inputLengthLimit: Int = 0) {
        self.viewState = ViewState(inputCopy: input.wrappedValue)
        self._input = input
        self.title = title
        self.inputLengthLimit = inputLengthLimit
    }
    
    var body: some View {
        @Bindable var viewState = viewState
        
        TextField(title, text: $viewState.inputCopy)
            .onReceive(Just(viewState.inputCopy), perform: { _ in
                let limit = 50
                if viewState.inputCopy.count > limit {
                    viewState.inputCopy = String(viewState.inputCopy.prefix(limit))
                }
            })
        
        Button(action: {
            // Trimming, just in case the user added a space in the end
            viewState.inputCopy = viewState.inputCopy.trimmingCharacters(
                in: .whitespacesAndNewlines
            )
            input = viewState.inputCopy
            dismiss()
        }) {Text("Save")}
            .disabled(viewState.inputCopy.isEmpty)
        
        Button(action: {dismiss()}) {
            Text("Cancel")
        }
    }
    
}

#Preview {
    PreviewWrapper()
}

struct PreviewWrapper: View {
    @State private var text = "Test"
    @State private var isOpen = true
    
    var body: some View {
        Text(text)
            .onTapGesture {
                isOpen = true
            }
            .alert("Title", isPresented: $isOpen) {
                SaveTextDialog(input: $text, title: "Title")
            } message: {
                Text("Message")
            }
    }
}

// TODO: Make a Preview wrapper for this ...

extension SaveTextDialog {
    
    @Observable
    class ViewState {
        var inputCopy: String
        
        init(inputCopy: String) {
            self.inputCopy = inputCopy
        }
    }
}
