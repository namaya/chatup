//
//  ChatroomRow.swift
//  chatup
//
//  Created by Nicholas Amaya on 11/7/23.
//

import SwiftUI

struct ChatroomRow: View {
    var chatroom: Chatroom
    
    var body: some View {
        HStack {
            Text("image")
                .foregroundStyle(.clear)
            VStack {
                HStack {
                    Text(chatroom.name)
                        .bold()
                    Spacer()
                    Text("test")
                        .foregroundStyle(.gray)
                        .padding(.trailing)
                }
                HStack {
                    Text(chatroom.messages.last?.content ?? "")
                        .foregroundStyle(.gray)
                        .font(.system(size: 15))
                        .lineLimit(2)
                        .padding(.trailing)
                }
//                Divider()
            }
        }

    }
}

#Preview {
    var exampleChatroom = Chatroom()
    exampleChatroom.name = "name"

    return ChatroomRow(chatroom: exampleChatroom)
}
