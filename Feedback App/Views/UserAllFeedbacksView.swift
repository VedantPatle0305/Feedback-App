//
//  UserAllFeedbackView.swift
//  Feedback App
//
//  Created by Vedant Patle on 19/09/25.
//

import SwiftUI

struct UserAllFeedbacksView: View {
    var feedbacks: [Feedback] {
        FeedbackService.shared.feedbacks.sorted { $0.date > $1.date }
    }
    
    var body: some View {
        List {
            ForEach(feedbacks) { fb in
                VStack(alignment: .leading, spacing: 6) {
                    Text(userName(for: fb.userId) ?? "Unknown")
                        .font(.headline)
                    Text(fb.message)
                    Text(dateString(fb.date))
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding(.vertical, 6)
            }
        }
        .navigationTitle("All Feedbacks")
    }
    
    private func userName(for id: UUID) -> String? {
        AuthService.shared.users.first(where: { $0.id == id })?.name
    }
    
    private func dateString(_ date: Date) -> String {
        let df = DateFormatter()
        df.dateStyle = .medium
        df.timeStyle = .short
        return df.string(from: date)
    }
}


#Preview {
    UserAllFeedbacksView()
}
