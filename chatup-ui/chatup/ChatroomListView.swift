//
//  ChatroomList.swift
//  chatup
//
//  Created by Nicholas Amaya on 9/9/23.
//

import SwiftUI
import GRPC
import NIOPosix
import SwiftProtobuf

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
                .task {
                    guard let serverHost = Bundle.main.infoDictionary?["ChatUp Server Host"] as? String,
                          let serverPort = Bundle.main.infoDictionary?["ChatUp Server Port"] as? Int
                    else {
                        print("Couldn't fetch server URL.")
                        return
                    }
                    
                    let group = MultiThreadedEventLoopGroup(numberOfThreads: 1)
                    
                    do {
                        let channel = try GRPCChannelPool.with(target: .hostAndPort(serverHost, serverPort), transportSecurity: .plaintext, eventLoopGroup: group)

                        print("Got channel...")
                        
                        let client = ChatUpServerAsyncClient(channel: channel)
                        
                        let request = Google_Protobuf_Empty()
                        
                        print("Sending request to backend...")
                        
                        let chatroomList = try await client.listChatrooms(request)
                        
                        self.chatrooms = chatroomList.chatrooms
                        
                        print("Retrieved chatrooms! \(self.chatrooms)")
                    } catch let error {
                        print("Couldn't connect to server. Error: \(error)")
                    }
                    
                }
        }
    }
}

/// Define the views to render in the preview pane in XCode
#Preview {
    ChatroomListView()
}

