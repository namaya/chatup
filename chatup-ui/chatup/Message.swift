//
//  Message.swift
//  chatup
//
//  Created by Nicholas Amaya on 11/8/23.
//

import Foundation

struct Message {
    var id: UUID {
        UUID()
    }
    var author: String
    var content: String
}
