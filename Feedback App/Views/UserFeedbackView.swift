//
//  UserFeedbackView.swift
//  Feedback App
//
//  Created by Vedant Patle on 19/09/25.
//

import SwiftUI

struct UserFeedbackView: View {
    @StateObject private var vm: UserFeedbackViewModel
    var onLogout: () -> Void
    
    init(user: User, onLogout: @escaping () -> Void) {
        _vm = StateObject(wrappedValue: UserFeedbackViewModel(user: user))
        self.onLogout = onLogout
    }
    
    var body: some View {
        Form {
            Section(header: Text("Your Info")) {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Logged in as").font(.caption)
                        Text(AuthService.shared.currentUser?.name ?? "-")
                        Text(AuthService.shared.currentUser?.email ?? "")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    Button("Logout") {
                        onLogout()
                    }
                    .foregroundColor(.red)
                }
            }
            
            Section(header: Text("Your Feedback")) {
                if vm.savedMessage == nil {
                    // No feedback yet → show input + submit button
                    TextEditor(text: $vm.message)
                        .frame(minHeight: 100)
                    
                    Button("Submit") {
                        vm.submit()
                    }
                    .frame(maxWidth: .infinity)
                } else {
                    // Feedback exists → show message and edit option
                    VStack(alignment: .leading, spacing: 8) {
                        Text(vm.savedMessage ?? "")
                            .padding(.vertical, 4)
                        Text("Submitted on \(dateString())")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        Button("Edit Feedback") {
                            // Enable editing
                            vm.message = vm.savedMessage ?? ""
                            vm.savedMessage = nil
                        }
                        .buttonStyle(.bordered)
                    }
                }
            }
            
            if let error = vm.errorMessage {
                Section {
                    Text(error).foregroundColor(.red)
                }
            }
        }
        .navigationTitle("Feedback")
        .toolbarTitleDisplayMode(.inline)
    }
    
    private func dateString() -> String {
        if let fb = FeedbackService.shared.feedbackForUser(AuthService.shared.currentUser!.id) {
            let df = DateFormatter()
            df.dateStyle = .medium
            df.timeStyle = .short
            return df.string(from: fb.date)
        }
        return "-"
    }
}



#Preview {
    let dummyUser = User(
        name: "Test User",
        email: "test@example.com",
        password: "1234",
        isAdmin: false
    )
    
    return NavigationView {
        UserFeedbackView(user: dummyUser) {
            print("Logout tapped")
        }
    }
}
