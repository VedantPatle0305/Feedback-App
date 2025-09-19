//
//  LoginView.swift
//  Feedback App
//
//  Created by Vedant Patle on 19/09/25.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var vm = LoginViewModel()
    var onLogin: (User) -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Customer Feedback")
                .font(.largeTitle).bold()
            
            TextField("Email", text: $vm.email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
            
            SecureField("Password", text: $vm.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            if let error = vm.errorMessage {
                Text(error).foregroundColor(.red)
            }
            
            Button("Login") {
                vm.login()
                if let user = vm.loggedInUser {
                    onLogin(user)
                }
            }
            .buttonStyle(.borderedProminent)
            .frame(maxWidth: .infinity)
            
            NavigationLink("Register", destination: RegistrationView())
                .padding(.top, 8)
            
            Spacer()
            
            Text("Admin demo: admin@gmail.com / admin123")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
    }
}

