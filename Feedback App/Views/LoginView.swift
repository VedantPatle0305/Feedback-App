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
        VStack{
            Text("Customer Feedback")
                .font(.title).bold()
                .fontDesign(.monospaced)
            
            Spacer()
            
            VStack(spacing:15){
                Text("Login")
                    .font(.headline)
                    .fontWeight(.bold)
                    .fontWidth(.expanded)
                
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
                
                NavigationLink("Don't have an account? Register", destination: RegistrationView())
                    .padding(.top, 8)
                    .foregroundColor(Color.primary)
                
            }
            .padding(20)
//            .border(Color.gray, width: 1)
            .background(
                Color.secondary.opacity(0.2)
                    .cornerRadius(20)
            )
            

            
            Spacer()
            
            Text("Admin demo: admin@gmail.com / admin123")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
//        .border(Color.gray, width: 1)
    }
}

#Preview {
    LoginView { user in
        print("Logged in as \(user.email)")
    }
}

