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
            Text("test")
            VStack {
                Text(chatroom.name)
                    .multilineTextAlignment(.trailing)
                Text(chatroom.messages.last ?? "")
                    .foregroundStyle(.gray)
            }
        }

    }
}

#Preview {
    ChatroomRow(chatroom: chatrooms[0])
}
