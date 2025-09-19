//
//  LoginViewModel.swift
//  Feedback App
//
//  Created by Vedant Patle on 19/09/25.
//

import Foundation

final class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage: String? = nil
    @Published var loggedInUser: User? = nil
    
    func login() {
        do {
            let user = try AuthService.shared.login(email: email, password: password)
            loggedInUser = user
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}

