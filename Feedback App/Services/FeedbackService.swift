//
//  FeedbackService.swift
//  Feedback App
//
//  Created by Vedant Patle on 19/09/25.
//

import Foundation

final class FeedbackService {
    static let shared = FeedbackService()
    private(set) var feedbacks: [Feedback] = []
    
    private init() {
        load()
    }
    
    private func load() {
        if let saved: [Feedback] = LocalStorage.shared.load([Feedback].self, forKey: StorageKeys.feedbacks) {
            feedbacks = saved
        } else {
            feedbacks = []
        }
    }
    
    private func save() {
        LocalStorage.shared.save(feedbacks, forKey: StorageKeys.feedbacks)
    }
    
    func feedbackForUser(_ userId: UUID) -> Feedback? {
        return feedbacks.first(where: { $0.userId == userId })
    }
    
    func addOrUpdateUserFeedback(userId: UUID, message: String) {
        if let idx = feedbacks.firstIndex(where: { $0.userId == userId }) {
            feedbacks[idx].message = message
            feedbacks[idx].date = Date()
        } else {
            let fb = Feedback(userId: userId, message: message)
            feedbacks.append(fb)
        }
        save()
    }
    
    func addFeedback(_ feedback: Feedback) {
        feedbacks.append(feedback)
        save()
    }
    
    func updateFeedback(_ feedback: Feedback) {
        if let idx = feedbacks.firstIndex(where: { $0.id == feedback.id }) {
            feedbacks[idx] = feedback
            save()
        }
    }
    
    func deleteFeedback(id: UUID) {
        feedbacks.removeAll(where: { $0.id == id })
        save()
    }
}

