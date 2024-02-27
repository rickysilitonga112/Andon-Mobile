//
//  LoginView.swift
//  MobileAndon
//
//  Created by Ricky Silitonga on 26/02/24.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()
    @State private var isValidEmail = false
    @State private var isValidPassword = false
    
    var body: some View {
        NavigationStack() {
            VStack {
                Spacer()
                AuthHeaderView()
                
                HStack {
                    Text("Login To Your Account")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.top, 50)
                    
                    Spacer()
                }
                
                VStack(spacing: 24) {
                    AMTextField(text: $viewModel.email, placeholder: "Email", isSecure: false)
                        .textInputAutocapitalization(.never)
                        .onChange(of: viewModel.email) {
                            self.isValidEmail = viewModel.isValidEmail()
                        }
                       
                    AMTextField(text: $viewModel.password, placeholder: "Password", isSecure: true)
                        .onChange(of: viewModel.password) {
                            if viewModel.password.count >= 6 {
                                self.isValidPassword = true
                            }
                        }
            
                }
                .padding(.top, 20)
                
                HStack {
                    Spacer()
                    Button {
                        // handle forgot password
                    } label: {
                        Text("Forgot password?")
                            .foregroundColor(.gray)
                    }
                }
                .padding(.vertical)
                
                AMPrimaryButton(title: "Sign In", color: (isValidEmail && isValidPassword) ? .blue : .gray) {
                    Task {
                        try await viewModel.signIn()
                    }
                }
                .padding(.top, 40)
                
                Spacer()
                
                NavigationLink {
                    RegisterView()
                        .navigationBarBackButtonHidden()
                } label: {
                    HStack {
                        Text("Don't have an account?")
                            .foregroundColor(.gray)
                        Text("Register")
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
    LoginView()
}
