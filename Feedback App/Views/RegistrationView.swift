//
//  RegistrationView.swift
//  Feedback App
//
//  Created by Vedant Patle on 19/09/25.
//

import SwiftUI

struct RegistrationView: View {
    @StateObject private var vm = RegistrationViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(alignment: .center, spacing: 20){
            VStack(spacing: 20){
                Text("Register")
                    .font(.headline)
                    .fontWeight(.bold)
                    .fontWidth(.expanded)
                
                TextField("Name", text: $vm.name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                
                TextField("Email", text: $vm.email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                
                SecureField("Password", text: $vm.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                if let error = vm.errorMessage {
                    Section {
                        Text(error).foregroundColor(.red)
                    }
                }
                
                Button("Register") {
                    vm.register()
                    if vm.success {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                .buttonStyle(.borderedProminent)
                .frame(maxWidth: .infinity)
                

                NavigationLink("Already have an account? Login") {
                    LoginView { _ in }
                }
                .padding(.top, 8)
                .foregroundColor(Color.primary)
                
            }
            .padding(20)
            .background(Color.gray.opacity(0.2).cornerRadius(20))
        }
        .padding()
//        .navigationTitle("Register")
    }
}



#Preview {
    RegistrationView()
}
