//
//  ChatroomList.swift
//  chatup
//
//  Created by Nicholas Amaya on 9/9/23.
//

import SwiftUI
import Logging
import FirebaseAuth

struct ChatroomListView: View {
    @Binding var currentUser: FirebaseAuth.User?
    @StateObject private var chatroomsObservable = MyChatroomsObservable()
    
    @State private var isAddChatroomModalShowing = false;
    
    var body: some View {
        NavigationStack {
            List(chatroomsObservable.chatrooms, id: \.id) { chatroom in
                NavigationLink {
                    ChatroomDetail(chatroom: chatroom)
                } label: {
                    ChatroomRow(chatroom: chatroom)
                }
            }
            .navigationTitle("Chatrooms")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        isAddChatroomModalShowing.toggle()
                    }) {
                        Image(systemName: "plus")
                    }
                    .sheet(isPresented: $isAddChatroomModalShowing, onDismiss: {}) {
                        AddChatroomView()
                    }
                }
            }
            .task {
                await chatroomsObservable.loadChatrooms()
            }
        }
    }
}

/// Define the views to render in the preview pane in XCode
#Preview {
    struct PreviewWrapper: View {
        @State var currentUser: FirebaseAuth.User? = nil
        
        var body: some View {
            ChatroomListView(currentUser: $currentUser)
        }
    }
    
    return PreviewWrapper()
}

