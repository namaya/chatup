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
    @Binding var currentUser: FirebaseAuth.User?
    
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
                TextField("Email", text: $username)
                SecureField("Password", text: $password)
                    .padding(2)
                Button("Sign In") {
                    logger.info("Signing in...")
                    Auth.auth().signIn(withEmail: username, password: password) { authResult, error in
                        guard error == nil, authResult != nil else {
                             logger.error("Couldn't sign user in. Error: \(error)")
                            return
                        }
                        
                        logger.info("User \(authResult?.user.email) signed in.")
                        
                        currentUser = Auth.auth().currentUser
                        
                    }
                }
                .disabled(username.isEmpty || password.isEmpty)
                .padding(2)
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
        @State var currentUser: FirebaseAuth.User? = nil
        
        var body: some View {
            if currentUser == nil {
                UserSignInView(currentUser: $currentUser)
            } else {
                Text("Success!")
            }
        }
    }
    
    return PreviewWrapper()
}
