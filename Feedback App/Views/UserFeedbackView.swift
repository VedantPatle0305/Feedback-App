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
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Logged in as").font(.caption)
                    Text(AuthService.shared.currentUser?.name ?? "userName")
                    Text(AuthService.shared.currentUser?.email ?? "Email")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
                Spacer()
                Button("Logout") {
                    onLogout()
                }
                .foregroundColor(.red)
            }
            .padding()
            .background(
                Color.gray.opacity(0.1)
                    .cornerRadius(10)
            )
            
            Spacer()
            
            VStack {
                if vm.savedMessage == nil {
                    // No feedback yet → show input + submit button
                    VStack{
                        Text("Enter your feedback here...")
                        TextEditor(text: $vm.message)
                            .frame(minHeight: 100)
                            .frame(maxHeight: 160)
                            .cornerRadius(20)
                        
                        Button("Submit") {
                            vm.submit()
                        }
                        .padding()
                        .buttonStyle(.borderedProminent)
                        .frame(maxWidth: .infinity)
                    }
                    .padding(20)
                    .background(
                        Color.secondary.opacity(0.2)
                        .cornerRadius(20)
                    )

                } else {
                    // Feedback exists → show message and edit option
                    VStack(alignment: .center, spacing: 40) {
                        VStack(alignment: .leading){
                            Text(vm.savedMessage ?? "Feedback")
                                .padding(.vertical, 4)
                            
                            Text("Submitted on \(dateString())")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        .frame(width: UIScreen.main.bounds.width*0.85)
                        
                        HStack{
                            Button("Edit Feedback") {
                                // Enable editing
                                vm.message = vm.savedMessage ?? ""
                                vm.savedMessage = nil
                            }
                            .buttonStyle(.bordered)
                        }
                        .frame(width: UIScreen.main.bounds.width*0.85)
                            
                    }
                    .padding()
                    .frame(width: UIScreen.main.bounds.width*0.85)
                    .background(
                        Color.secondary.opacity(0.2)
                        .cornerRadius(20)
                    )
                    
                }
            }
//            .border(Color.gray)
            
            if let error = vm.errorMessage {
                Section {
                    Text(error).foregroundColor(.red)
                }
            }
            Spacer()
            Spacer()
        }
        .padding()
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
