//
//  Chatroom.swift
//  chatup
//
//  Created by Nicholas Amaya on 9/9/23.
//

import Foundation

let chatrooms = [Chatroom(name: "Chatroom1", users: [], messages: ["Hey man, how are you doing?"])]

struct Chatroom {
    var name: String
    var users: [String]
    var messages: [String]
}
