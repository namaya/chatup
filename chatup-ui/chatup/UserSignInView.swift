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
    var body: some View {
        Button(action: {
            let logger = Logger(label: "com.namaya.usersigninview")
            let email = "n3amaya@gmail.com"
            let password = "password123"
            
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                guard error == nil else {
                     logger.error("Couldn't sign user in. Error: \(error)")
                    return
                }
                
                let storage = SecureStorage()
                
//                storage.storeUserCredentials(token: authResult?.getTokenWi)
                
                print("User \(authResult?.user.email) signed in.")
                
                print("success!")
            }
        }, label: {
            Text("Sign In")
        })
//        .background(.blue, in: .containerRelative)
    }
}

#Preview {
    UserSignInView()
}
