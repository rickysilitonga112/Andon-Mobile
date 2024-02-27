//
//  RegisterView.swift
//  MobileAndon
//
//  Created by Ricky Silitonga on 26/02/24.
//

import SwiftUI

struct RegisterView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var viewModel = RegisterViewModel()
    
    @State private var confirmPassword = ""
    @State private var isValidEmail = false
    @State private var isValidPassword = false
    @State private var isValidConfirmPassword = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                AuthHeaderView()
                
                HStack {
                    Text("Create your account")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.top, 50)
                    
                    Spacer()
                }
                
                VStack(spacing: 24) {
                    AMTextField(text: $viewModel.email, placeholder: "Email", isSecure: false)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .onChange(of: viewModel.email) {
                            self.isValidEmail = viewModel.isValidEmail()
                        }
                    
                    AMTextField(text: $viewModel.fullName, placeholder: "Full Name", isSecure: false)
                        .textInputAutocapitalization(.none)
                       
                    AMTextField(text: $viewModel.password, placeholder: "Password", isSecure: true)
                        .onChange(of: viewModel.password) {
                            if viewModel.password.count > 6 {
                                self.isValidPassword = true
                            }
                        }
                    
                    AMTextField(text: $confirmPassword, placeholder: "Confirm Password", isSecure: true)
                        .onChange(of: confirmPassword) {
                            if confirmPassword.count > 6 {
                                self.isValidConfirmPassword = true
                            }
                        }
                }
                .padding(.top, 20)
                
                AMPrimaryButton(title: "Register", color: (isValidEmail && isValidPassword && isValidConfirmPassword) ? .blue : .gray) {
                    guard viewModel.password.count >= 6 else  {
                        print("DEBUG: Password is to short")
                        return
                    }
                    guard viewModel.password == confirmPassword else {
                        print("DEBUG: Password doesn't match")
                        return
                    }
                    // handle register
                    Task {
                        try await viewModel.register()
                    }
                }
                .padding(.top, 40)
                
                Spacer()
                Button {
                    dismiss()
                } label: {
                    HStack {
                        Text("Already have an account? ")
                            .foregroundColor(.gray)
                        Text("Login")
                            .foregroundColor(.blue)
                    }
                    .fontWeight(.semibold)
                }
            }
            .padding(.horizontal)
            .ignoresSafeArea(.keyboard)
        }
    }
    
}

#Preview {
    RegisterView()
}
