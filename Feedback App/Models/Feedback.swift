//
//  Feedback.swift
//  Feedback App
//
//  Created by Vedant Patle on 19/09/25.
//

import Foundation

struct Feedback: Codable, Identifiable, Equatable {
    let id: UUID
    var userId: UUID
    var message: String
    var date: Date
    
    init(id: UUID = UUID(), userId: UUID, message: String, date: Date = Date()) {
        self.id = id
        self.userId = userId
        self.message = message
        self.date = date
    }
}
