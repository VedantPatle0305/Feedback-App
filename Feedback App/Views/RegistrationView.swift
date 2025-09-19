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
        Form {
            Section(header: Text("Details")) {
                TextField("Name", text: $vm.name)
                TextField("Email", text: $vm.email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                SecureField("Password", text: $vm.password)
            }
            
            if let error = vm.errorMessage {
                Section {
                    Text(error).foregroundColor(.red)
                }
            }
            
            Section {
                Button("Register") {
                    vm.register()
                    if vm.success {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
        .navigationTitle("Register")
    }
}



#Preview {
    RegistrationView()
}
