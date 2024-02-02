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
import Logging

struct ChatroomListView: View {
    @State private var chatrooms: [Chatroom] = []
    @State private var isAddChatroomModalShowing = false;
    
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
                    let logger = Logger(label: "com.namaya.chatroomlistview")
                    guard let serverHost = Bundle.main.infoDictionary?["ChatUp Server Host"] as? String,
                          let serverPort = Bundle.main.infoDictionary?["ChatUp Server Port"] as? Int
                    else {
                        logger.error("Couldn't fetch server URL.")
                        return
                    }
                    
                    let group = MultiThreadedEventLoopGroup(numberOfThreads: 1)
                    
                    do {
                        let channel = try GRPCChannelPool.with(target: .hostAndPort(serverHost, serverPort), transportSecurity: .plaintext, eventLoopGroup: group)

                        logger.debug("Recieved gRPC channel...")
                        
                        let client = ChatUpServerAsyncClient(channel: channel)
                        
                        let request = Google_Protobuf_Empty()
                        
                        logger.debug("Sending request to backend...")
                        
                        let chatroomList = try await client.listChatrooms(request)
                        
                        self.chatrooms = chatroomList.chatrooms
                        
                        logger.info("Retrieved \(self.chatrooms.count) chatrooms.")
                    } catch let error {
                        logger.error("Couldn't connect to server. Error: \(error)")
                    }
                    
                }
        }
    }
}

/// Define the views to render in the preview pane in XCode
#Preview {
    ChatroomListView()
}

