//
//  AuthService.swift
//  Feedback App
//
//  Created by Vedant Patle on 19/09/25.
//

import Foundation

final class AuthService {
    static let shared = AuthService()
    private(set) var users: [User] = []
    private(set) var currentUser: User? = nil
    
    private init() {
        loadUsers()
        seedAdminIfNeeded()
    }
    
    private func loadUsers() {
        if let saved: [User] = LocalStorage.shared.load([User].self, forKey: StorageKeys.users) {
            users = saved
        } else {
            users = []
        }
    }
    
    private func saveUsers() {
        LocalStorage.shared.save(users, forKey: StorageKeys.users)
    }
    
    private func seedAdminIfNeeded() {
        if !users.contains(where: { $0.isAdmin }) {
            let admin = User(name: "Admin", email: "admin@gmail.com", password: "admin123", isAdmin: true)
            users.append(admin)
            saveUsers()
        }
    }
    
    func register(name: String, email: String, password: String, isAdmin: Bool = false) throws {
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty else {
            throw AuthError.invalid("Name is required")
        }
        guard email.contains("@"), email.contains(".") else {
            throw AuthError.invalid("Enter a valid email")
        }
        guard password.count >= 4 else {
            throw AuthError.invalid("Password must be at least 4 characters")
        }
        if users.contains(where: { $0.email.lowercased() == email.lowercased() }) {
            throw AuthError.invalid("Email already registered")
        }
        
        let user = User(name: name, email: email.lowercased(), password: password, isAdmin: isAdmin)
        users.append(user)
        saveUsers()
    }
    
    func login(email: String, password: String) throws -> User {
        guard let user = users.first(where: { $0.email.lowercased() == email.lowercased() && $0.password == password }) else {
            throw AuthError.invalid("Invalid email or password")
        }
        currentUser = user
        return user
    }
    
    func logout() {
        currentUser = nil
    }
    
    enum AuthError: LocalizedError {
        case invalid(String)
        var errorDescription: String? {
            switch self {
            case .invalid(let message): return message
            }
        }
    }
}
