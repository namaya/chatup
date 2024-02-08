//
//  UserSignInView.swift
//  chatup
//
//  Created by Nicholas Amaya on 2/3/24.
//

import SwiftUI
import FirebaseAuth
import Logging

struct UserSignInView: View {
    
    private let logger = Logger(label: "com.namaya.usersigninview")
    
    @State private var username: String = ""
    @State private var password: String = ""
    @Binding var isAuthenticated: Bool
    
    var body: some View {
        VStack {
            VStack {
                Spacer()
                Image("Logo")
                    .resizable()
                    .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                Spacer()
            }
            VStack {
                Spacer()
                TextField("User name (email address)", text: $username)
                TextField("Password", text: $password)
                Button("Sign In") {
                    Auth.auth().signIn(withEmail: username, password: password) { authResult, error in
                        guard error == nil else {
                             logger.error("Couldn't sign user in. Error: \(error)")
                            return
                        }
                        
                        logger.info("User \(authResult?.user.email) signed in.")
                        
                        isAuthenticated = true
                    }
                    
                    print("isAuthenticated: \(isAuthenticated)")
                }
                Button(action: {
                    
                }, label: {
                    Text("Register")
                        .foregroundStyle(.secondary)
                })
                Spacer()
            }
        }
        .padding()
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State var isAuthenticated: Bool = false
        
        var body: some View {
            if !isAuthenticated {
                UserSignInView(isAuthenticated: $isAuthenticated)
            } else {
                Text("Success!")
            }
        }
    }
    
    return PreviewWrapper()
}
