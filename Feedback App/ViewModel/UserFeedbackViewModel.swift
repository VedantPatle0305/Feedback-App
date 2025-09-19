//
//  UserFeedbackViewModel.swift
//  Feedback App
//
//  Created by Vedant Patle on 19/09/25.
//

import Foundation

final class UserFeedbackViewModel: ObservableObject {
    @Published var message: String = ""
    @Published var savedMessage: String? = nil
    @Published var errorMessage: String? = nil
    
    private let user: User
    
    init(user: User) {
        self.user = user
        loadExisting()
    }
    
    func loadExisting() {
        if let fb = FeedbackService.shared.feedbackForUser(user.id) {
            message = fb.message
            savedMessage = fb.message
        } else {
            message = ""
            savedMessage = nil
        }
    }
    
    func submit() {
        let trimmed = message.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else {
            errorMessage = "Please enter feedback"
            return
        }
        FeedbackService.shared.addOrUpdateUserFeedback(userId: user.id, message: trimmed)
        savedMessage = trimmed
        errorMessage = nil
    }
}

