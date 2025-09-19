//
//  RootView.swift
//  Feedback App
//
//  Created by Vedant Patle on 19/09/25.
//

import SwiftUI

struct RootView: View {
    @State private var loggedInUser: User? = AuthService.shared.currentUser
    
    var body: some View {
        NavigationView {
            if let user = loggedInUser {
                if user.isAdmin {
                    AdminDashboardView(user: user, onLogout: { handleLogout() })
                } else {
                    UserFeedbackView(user: user, onLogout: { handleLogout() })
                }
            } else {
                LoginView(onLogin: { user in
                    loggedInUser = user
                })
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private func handleLogout() {
        AuthService.shared.logout()
        loggedInUser = nil
    }
}

#Preview {
    RootView()
}

