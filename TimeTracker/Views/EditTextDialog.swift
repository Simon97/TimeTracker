//
//  EditTextDialog.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 03/06/2024.
//

import Combine
import SwiftUI

struct EditTextDialog: View {
    
    @Binding var showDialog: Bool
    @Binding var input: String
    
    let title: String
    let inputLengthLimit: Int
    let message: String
    
    @Environment(\.dismiss) var dismiss
    
    @State private var viewState: ViewState
    
    init(
        showDialog: Binding<Bool>,
        input: Binding<String>,
        title: String,
        message: String,
        inputLengthLimit: Int) {
            self.title = title
            self.inputLengthLimit = inputLengthLimit
            self.message = message
            
            self.viewState = ViewState(inputCopy: input.wrappedValue)
            
            self._input = input
            self._showDialog = showDialog
        }
    
    var body: some View {
        Color.clear
            .frame(width: 0, height: 0)
            .alert(title, isPresented: $showDialog) {
                TextField(title, text: $viewState.inputCopy)
                    .onReceive(
                        Just(viewState.inputCopy), perform: { _ in
                        let limit = inputLengthLimit
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
            } message: {
                Text(message)
            }
    }
}

#Preview {
    EditTextDialogPreviewWrapper()
}

struct EditTextDialogPreviewWrapper: View {
    @State private var text = "Test"
    @State private var isOpen = true
    
    var body: some View {
        Text(text)
            .onTapGesture {
                isOpen.toggle()
            }
        
        EditTextDialog(
            showDialog: $isOpen,
            input: $text,
            title: "Title",
            message: "Message", inputLengthLimit: 7
        )
    }
}

extension EditTextDialog {
    
    @Observable
    class ViewState {
        var inputCopy: String
        
        init(inputCopy: String) {
            self.inputCopy = inputCopy
        }
        
    }
}
