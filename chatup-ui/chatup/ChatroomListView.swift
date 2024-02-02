//
//  ChatroomList.swift
//  chatup
//
//  Created by Nicholas Amaya on 9/9/23.
//

import SwiftUI

struct ChatroomListView: View {
    @State private var chatrooms: [Chatroom] = []
    
    var body: some View {
        NavigationStack {
            List(chatrooms, id: \.id) { chatroom in
                NavigationLink {
                    ChatroomDetail(chatroom: chatroom)
                } label: {
                    ChatroomRow(chatroom: chatroom)
                }
            }.navigationTitle("Chatrooms")
                .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        print("Added new chatroom.")
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}

/// Define the views to render in the preview pane in XCode
#Preview {
    ChatroomListView()
}

