//
//  ContentView.swift
//  chatup
//
//  Created by Nicholas Amaya on 9/8/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var isLoggedIn: Bool = false;
    
    var body: some View {
        if (isLoggedIn) {
            ChatroomListView()
        } else {
            UserSignInView()
        }
    }
}

#Preview {
    ContentView()
}
