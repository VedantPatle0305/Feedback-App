//
//  RegistrationViewModel.swift
//  Feedback App
//
//  Created by Vedant Patle on 19/09/25.
//

import Foundation

final class RegistrationViewModel: ObservableObject {
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    
    @Published var errorMessage: String? = nil
    @Published var success = false
    
    func register() {
        do {
            try AuthService.shared.register(
                name: name,
                email: email,
                password: password,
                isAdmin: false   // always normal user
            )
            success = true
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
