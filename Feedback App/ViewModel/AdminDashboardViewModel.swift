//
//  AdminDashboardViewModel.swift
//  Feedback App
//
//  Created by Vedant Patle on 19/09/25.
//

import Foundation

final class AdminDashboardViewModel: ObservableObject {
    @Published var feedbacks: [Feedback] = []
    
    init() {
        load()
    }
    
    func load() {
        feedbacks = FeedbackService.shared.feedbacks.sorted { $0.date > $1.date }
    }
    
    func delete(_ id: UUID) {
        FeedbackService.shared.deleteFeedback(id: id)
        load()
    }
    
    func refresh() {
        load()
    }
}

