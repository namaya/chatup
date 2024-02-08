//
//  MessageInputView.swift
//  chatup
//
//  Created by Nicholas Amaya on 2/2/24.
//

import SwiftUI

struct MessageInputView: View {
    
    @State private var textInput: String = ""
    
    var body: some View {
        HStack {
            TextField("Type a message", text: $textInput)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button(action: {}) {
                Text("Send")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
        }
    }
}

#Preview {
    MessageInputView()
}
