//
//  ChatroomDetail.swift
//  chatup
//
//  Created by Nicholas Amaya on 11/8/23.
//

import SwiftUI


struct ChatroomDetail: View {
    var chatroom: Chatroom
    
    @State private var textInput: String = ""

    var body: some View {
        VStack {
            List(chatroom.messages, id: \.id) { message in
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
            .navigationBarTitle(chatroom.name)
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
    ChatroomDetail(chatroom: chatrooms[0])
}
