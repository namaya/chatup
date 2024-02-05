//
//  chatupApp.swift
//  chatup
//
//  Created by Nicholas Amaya on 9/8/23.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth


@main
struct chatupApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
