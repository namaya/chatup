//
//  Chatroom.swift
//  chatup
//
//  Created by Nicholas Amaya on 9/9/23.
//

import Foundation

let chatrooms = [
    Chatroom(name: "Chatroom1", users: [], messages: [
        Message(author: "Nick", content: "Hey man, how are you doing? This is a really long message that will get truncated bc it's longer than two lines."),
        Message(author: "Katelynn", content: "Hey man, how are you doing? This is a really long message that will get truncated bc it's longer than two lines."),
        Message(author: "Nick", content: "Hey man, how are you doing? This is a really long message that will get truncated bc it's longer than two lines."),
        Message(author: "Katelynn", content: "Hey man, how are you doing? This is a really long message that will get truncated bc it's longer than two lines."),
        Message(author: "Nick", content: "Hey man, how are you doing? This is a really long message that will get truncated bc it's longer than two lines."),
        Message(author: "Katelynn", content: "Hey man, how are you doing? This is a really long message that will get truncated bc it's longer than two lines.")
    ], lastUpdated: Date()),
    Chatroom(name: "Chatroom2", users: [], messages: [Message(author: "Katelynn", content: "Hey man, how are you doing? This is a really long message that will get truncated bc it's longer than two lines.")], lastUpdated: Date()),
    Chatroom(name: "Chatroom3", users: [], messages: [Message(author: "Nick", content: "Hey man, how are you doing? This is a really long message that will get truncated bc it's longer than two lines.")], lastUpdated: Date()),
    Chatroom(name: "Chatroom4", users: [], messages: [Message(author: "Katelynn", content: "Hey man, how are you doing? This is a really long message that will get truncated bc it's longer than two lines.")], lastUpdated: Date()),
    Chatroom(name: "Chatroom5", users: [], messages: [Message(author: "Nick", content: "Hey man, how are you doing? This is a really long message that will get truncated bc it's longer than two lines.")], lastUpdated: Date()),
    Chatroom(name: "Chatroom6", users: [], messages: [Message(author: "Katelynn", content: "Hey man, how are you doing? This is a really long message that will get truncated bc it's longer than two lines.")], lastUpdated: Date()),
    Chatroom(name: "Chatroom7", users: [], messages: [Message(author: "Nick", content: "Hey man, how are you doing? This is a really long message that will get truncated bc it's longer than two lines.")], lastUpdated: Date()),
    Chatroom(name: "Chatroom8", users: [], messages: [Message(author: "Katelynn", content: "Hey man, how are you doing? This is a really long message that will get truncated bc it's longer than two lines.")], lastUpdated: Date()),
    Chatroom(name: "Chatroom9", users: [], messages: [Message(author: "Nick", content: "Hey man, how are you doing? This is a really long message that will get truncated bc it's longer than two lines.")], lastUpdated: Date()),
]

struct Chatroom {
    var id: UUID {
        UUID()
    }
    var name: String
    var users: [String]
    var messages: [Message]
    var lastUpdated: Date
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
}
