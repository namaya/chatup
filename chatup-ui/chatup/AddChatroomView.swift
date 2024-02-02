//
//  AddChatroomView.swift
//  chatup
//
//  Created by Nicholas Amaya on 2/2/24.
//

import SwiftUI

struct AddChatroomView: View {
    @Environment(\.dismiss) private var dismissModal
    @State private var textInput: String = ""
    
    var body: some View {
        NavigationView {
            VStack() {
                HStack {
                    Text("To")
                        .foregroundStyle(.secondary)
                    TextField("", text: $textInput)
                        .textFieldStyle(.plain)
                        .foregroundStyle(.primary)
                }
                .padding(10)
                .border(.gray, width: 0.2)
                Spacer()
                MessageInputView()
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        dismissModal()
                    }) {
                        Text("Cancel")
                    }
                }
            }
            .navigationTitle("New Message")
            .toolbarBackground(Color.pink, for: .navigationBar)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    AddChatroomView()
}
