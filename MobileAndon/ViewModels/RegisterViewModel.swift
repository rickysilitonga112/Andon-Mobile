//
//  RegisterViewModel.swift
//  MobileAndon
//
//  Created by Ricky Silitonga on 26/02/24.
//

import Foundation

class RegisterViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var fullName: String = ""
    @Published var phoneNumber: String = ""
    @Published var password: String = ""

    @MainActor
    func register() async throws {
        try await AuthService.shared.signUp(with: email, fullName: fullName, phoneNumber: phoneNumber, password: password)
    }
    
    func validateEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func validatePhoneNumber() -> Bool {
        let phoneRegex = "^[0-9+]{0,1}+[0-9]{5,16}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: phoneNumber)
    }
}
