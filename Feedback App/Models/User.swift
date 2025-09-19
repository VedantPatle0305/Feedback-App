//
//  User.swift
//  Feedback App
//
//  Created by Vedant Patle on 19/09/25.
//

import Foundation

struct User: Codable, Identifiable, Equatable {
    let id: UUID
    var name: String
    var email: String
    var password: String
    var isAdmin: Bool
    
    init(id: UUID = UUID(), name: String, email: String, password: String, isAdmin: Bool = false) {
        self.id = id
        self.name = name
        self.email = email
        self.password = password
        self.isAdmin = isAdmin
    }
}
