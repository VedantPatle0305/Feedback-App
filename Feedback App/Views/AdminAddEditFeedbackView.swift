//
//  AdminAddEditFeedbackView.swift
//  Feedback App
//
//  Created by Vedant Patle on 19/09/25.
//

import SwiftUI

struct AdminAddEditFeedbackView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var isPresented: Bool
    var editing: Feedback?
    var onSave: () -> Void
    
    @State private var selectedUserId: UUID?
    @State private var message: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Select User")) {
                    Picker("User", selection: Binding(get: {
                        selectedUserId ?? AuthService.shared.users.first?.id
                    }, set: { selectedUserId = $0 })) {
                        ForEach(AuthService.shared.users) { user in
                            Text(user.name).tag(user.id as UUID?)
                        }
                    }
                }
                
                Section(header: Text("Feedback")) {
                    TextEditor(text: $message)
                        .frame(minHeight: 100)
                }
            }
            .navigationTitle(editing == nil ? "Add Feedback" : "Edit Feedback")
            .navigationBarItems(
                leading: Button("Cancel") { isPresented = false },
                trailing: Button("Save") { save() }
            )
            .onAppear {
                if let e = editing {
                    selectedUserId = e.userId
                    message = e.message
                } else {
                    selectedUserId = AuthService.shared.users.first?.id
                }
            }
        }
    }
    
    private func save() {
        guard let uid = selectedUserId else { return }
        let trimmed = message.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        
        if var e = editing {
            e.message = trimmed
            e.date = Date()
            FeedbackService.shared.updateFeedback(e)
        } else {
            let newFeedback = Feedback(userId: uid, message: trimmed)
            FeedbackService.shared.addFeedback(newFeedback)
        }
        
        onSave()
        isPresented = false
    }
}
    
//#Preview {
//    AdminAddEditFeedbackView()
//}
