//
//  ChatroomDetail.swift
//  chatup
//
//  Created by Nicholas Amaya on 11/8/23.
//

import SwiftUI


struct ChatroomDetail: View {
    var messages: [Message]
    
    @State private var textInput: String = ""

    var body: some View {
        VStack {
            List(messages, id: \.id) { message in
                HStack {
                    if message.author == clientUser.name {
                        Spacer()
                        Text(message.content)
                            .padding(10)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    } else {
                        Text(message.content)
                            .padding(10)
                            .background(Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        Spacer()
                    }
                }
            }
            .navigationBarTitle("Chat")
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
}

#Preview {
    ChatroomDetail(messages: chatrooms[0].messages)
}
