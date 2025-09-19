//
//  LocalStorage.swift
//  Feedback App
//
//  Created by Vedant Patle on 19/09/25.
//

import Foundation

enum StorageKeys {
    static let users = "assignment_users_v1"
    static let feedbacks = "assignment_feedbacks_v1"
}

final class LocalStorage {
    static let shared = LocalStorage()
    private let defaults = UserDefaults.standard
    
    private init() {}
    
    func save<T: Encodable>(_ value: T, forKey key: String) {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        if let data = try? encoder.encode(value) {
            defaults.set(data, forKey: key)
        }
    }
    
    func load<T: Decodable>(_ type: T.Type, forKey key: String) -> T? {
        guard let data = defaults.data(forKey: key) else { return nil }
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try? decoder.decode(type, from: data)
    }
}
