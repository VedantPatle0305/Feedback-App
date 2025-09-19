//
//  AdminDashboardView.swift
//  Feedback App
//
//  Created by Vedant Patle on 19/09/25.
//

import SwiftUI

struct AdminDashboardView: View {
    @StateObject private var vm = AdminDashboardViewModel()
    var user: User
    var onLogout: () -> Void
    @State private var showingAdd = false
    @State private var editingFeedback: Feedback? = nil
    
    var body: some View {
        List {
            ForEach(vm.feedbacks) { fb in
                VStack(alignment: .leading, spacing: 6) {
                    Text(userName(for: fb.userId) ?? "Unknown")
                        .bold()
                    Text(fb.message)
                    Text(dateString(fb.date))
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    HStack {
                        Spacer()
                        Button("Edit") {
                            editingFeedback = fb
                        }
                        .buttonStyle(.bordered)
                        
                        Button("Delete") {
                            vm.delete(fb.id)
                        }
                        .foregroundColor(.red)
                        .buttonStyle(.bordered)
                        Spacer()
                    }
                }
                .padding(.vertical, 6)
            }
        }
        .navigationTitle("Admin Dashboard")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Logout") { onLogout() }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Add") { showingAdd = true }
            }
        }
        .sheet(isPresented: $showingAdd) {
            AdminAddEditFeedbackView(isPresented: $showingAdd, editing: nil) {
                vm.refresh()
            }
        }
        .sheet(item: $editingFeedback) { feedback in
            AdminAddEditFeedbackView(isPresented: .constant(true), editing: feedback) {
                vm.refresh()
            }
        }
    }
    
    private func userName(for id: UUID) -> String? {
        AuthService.shared.users.first(where: { $0.id == id })?.name
    }
    
    private func dateString(_ date: Date) -> String {
        let df = DateFormatter()
        df.dateStyle = .short
        df.timeStyle = .short
        return df.string(from: date)
    }
}


//#Preview {
//    AdminDashboardView()
//}
