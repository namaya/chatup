//
//  User.swift
//  chatup
//
//  Created by Nicholas Amaya on 11/8/23.
//

import Foundation

var clientUser = User(name: "Nick")

struct User {
    var id: UUID {
        UUID()
    }
    
    var name: String
}
