//
//  ChatroomList.swift
//  chatup
//
//  Created by Nicholas Amaya on 9/9/23.
//

import SwiftUI

struct ChatroomList: View {
    var body: some View {
        NavigationStack {
            List(chatrooms, id: \.id) { chatroom in
                NavigationLink {
                    ChatroomDetail(chatroom: chatroom)
                } label: {
                    ChatroomRow(chatroom: chatroom)
                }
                
            }
        }
    }
}

/// Define the views to render in the preview pane in XCode
#Preview {
    ChatroomList()
}

