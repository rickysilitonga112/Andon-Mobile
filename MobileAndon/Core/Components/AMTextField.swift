//
//  AMTextField.swift
//  MobileAndon
//
//  Created by Ricky Silitonga on 26/02/24.
//

import SwiftUI

struct AMTextField: View {
    // properties
    @Binding var text: String
    let placeholder: String
    let isSecure: Bool
    
    @State var showPassword = false
    
    var body: some View {
        ZStack {
            if isSecure {
                if showPassword {
                    TextField(placeholder, text: $text)
                        .padding(.leading, 20)
                } else {
                    SecureField(placeholder, text: $text)
                        .padding(.leading, 20)
                }
                
                Image(systemName: showPassword ? "eye" : "eye.slash")
                    .contentTransition(.symbolEffect(.replace))
                    .foregroundColor(.gray)
                    .scaledToFit()
                    .frame(height: 20)
                    .padding(.trailing)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .onTapGesture {
                        showPassword.toggle()
                    }
            } else {
                TextField(placeholder, text: $text)
                    .padding(.leading, 20)
            }
        }
        .frame(height: 57)
        .overlay {
            RoundedRectangle(cornerRadius: 15)
                .inset(by: 0.5)
                .stroke(.gray.opacity(0.5), lineWidth: 1)   
        }
    }
}

#Preview {
    AMTextField(text: .constant(""), placeholder: "Password", isSecure: true)
}
