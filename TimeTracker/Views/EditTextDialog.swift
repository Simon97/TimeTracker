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
    
    @State private var internalCopy: String
    
    init(
        showDialog: Binding<Bool>,
        input: Binding<String>,
        title: String,
        message: String,
        inputLengthLimit: Int) {
            self.title = title
            self.inputLengthLimit = inputLengthLimit
            self.message = message
            self.internalCopy = input.wrappedValue
            
            self._input = input
            self._showDialog = showDialog
        }
    
    var body: some View {
        Color.clear
            .frame(width: 0, height: 0)
            .alert(title, isPresented: $showDialog) {
                TextField(title, text: $internalCopy)
                    .onReceive(
                        Just(internalCopy), perform: { _ in
                            let limit = inputLengthLimit
                            if internalCopy.count > limit {
                                internalCopy = String(internalCopy.prefix(limit))
                            }
                        })
                
                Button(action: saveAction) {Text("Save")}
                .disabled(internalCopy.isEmpty)
                
                Button(action: cancelAction) {Text("Cancel")}
                
            } message: {
                Text(message)
            }
            .onChange(of: self.showDialog) {
                internalCopy = input
            }
    }
    
    func saveAction() {
        // Trimming, just in case the user added a space in the end
        internalCopy = internalCopy.trimmingCharacters(
            in: .whitespacesAndNewlines
        )
        input = internalCopy
        internalCopy = ""
        dismiss()
    }
    
    func cancelAction() {
        internalCopy = ""
        dismiss()
    }
}

#Preview {
    EditTextDialogPreviewWrapper()
}

struct EditTextDialogPreviewWrapper: View {
    @State private var text = "Test"
    @State private var isOpen = true
    
    var body: some View {
        VStack {
            Text("Tap text below to edit:")
            Text(text)
                .padding()
                .onTapGesture {
                    isOpen.toggle()
                }
        }
        
        EditTextDialog(
            showDialog: $isOpen,
            input: $text,
            title: "Title",
            message: "Message", inputLengthLimit: 25
        )
    }
}
