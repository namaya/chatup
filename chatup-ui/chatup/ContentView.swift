//
//  ContentView.swift
//  chatup
//
//  Created by Nicholas Amaya on 9/8/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isAuthenticated: Bool = false
    
    var body: some View {
        if !isAuthenticated {
            UserSignInView(isAuthenticated: $isAuthenticated)
        } else {
            ChatroomListView()
        }
    }
}

#Preview {
    ContentView()
}
