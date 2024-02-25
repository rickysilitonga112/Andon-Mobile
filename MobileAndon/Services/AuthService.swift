//
//  AuthService.swift
//  MobileAndon
//
//  Created by Ricky Silitonga on 25/02/24.
//

import Firebase
import FirebaseAuth

class AuthService {
    static let shared = AuthService()
    
    @Published var userSession: FirebaseAuth.User?
    
    init() {
        self.userSession = Auth.auth().currentUser
        if let userSession = self.userSession {
            print("DEBUG: Current user session id: \(userSession.uid)")
        }
    }
}
