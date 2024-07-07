//
//  ErrorMessageBox.swift
//  TimeTracker
//
//  Created by Simon Svendsgaard Nielsen on 01/07/2024.
//

import SwiftUI

struct ErrorMessageBox: View {
    
    let errorMessage: String
    
    var body: some View {
        HStack {
            Image(systemName: "exclamationmark.triangle.fill")
                .foregroundColor(.red)
                .padding(.leading, 18)
            
            Spacer()
            
            Text(errorMessage)
                .foregroundStyle(Color.red)
                .padding(8)
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(.red, lineWidth: 1)
        )
    }
}

#Preview {
    VStack {
        ErrorMessageBox(errorMessage: "Error!")
            .padding()
        
        ErrorMessageBox(errorMessage: "A little longer error message")
            .padding()
        
        ErrorMessageBox(errorMessage: "A very much longer message. This is taking up multiple lines on an iPhone. Have a look at the Preview")
            .padding()
    }
}
