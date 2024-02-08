//
//  ContentView.swift
//  chatup
//
//  Created by Nicholas Amaya on 9/8/23.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    
    @State private var currentUser: FirebaseAuth.User? = nil
    
    var body: some View {
        if currentUser == nil {
            UserSignInView(currentUser: $currentUser)
        } else {
            ChatroomListView(currentUser: $currentUser)
        }
    }
}

#Preview {
    ContentView()
}
