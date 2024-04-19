//
//  AuthService.swift
//  MobileAndon
//
//  Created by Ricky Silitonga on 25/02/24.
//

import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift

@MainActor
class AuthService {
    static let shared = AuthService()
    
    @Published var userSession: FirebaseAuth.User?
    
    private let auth = Auth.auth()
    
    init() {
        self.userSession = Auth.auth().currentUser
        if let userSession = self.userSession {
            print("DEBUG: Current user session id: \(userSession.uid)")
        }
    }
    
    /// Handle sign in with email and password
    /// - Parameters:
    ///   - email: email that used for login
    ///   - password: password that use for login
    func signIn(with email: String, password: String) async throws {
        let result = try await auth.signIn(withEmail: email, password: password)
        self.userSession = result.user
    }
    
    /// Auth service function to handle sign up
    /// - Parameters:
    ///   - email: email to register
    ///   - fullName: full name to register
    ///   - password: password to register
    func signUp(with email: String, fullName: String, phoneNumber: String, password: String) async throws {
        let result = try await Auth.auth().createUser(withEmail: email, password: password)
        self.userSession = result.user
        let user = User(id: result.user.uid, email: email, fullName: fullName, phoneNumber: phoneNumber)
        try await uploadUserData(user)
        
        //  print("DEBUG: Failed to create user with error: \(error.localizedDescription)")
    }
    
    /// Function that handle sign out in firebase authentication
    func signOut() throws {
        try auth.signOut()
        // set user session locally to nil
        self.userSession = nil
        
        // set the user in user service to nil
        UserService.shared.currentUser = nil
    }
    
    /// Upload registered user data to the firebase firestore
    /// - Parameters:
    ///   - id: registered account id
    ///   - email: registered account email
    ///   - fullName: registered account full name
    private func uploadUserData(_ user: User) async throws {
        if let userData = try? Firestore.Encoder().encode(user) {
            try await Firestore.firestore().collection("users").document(user.id).setData(userData)
            UserService.shared.currentUser = user
        }
    }
}
