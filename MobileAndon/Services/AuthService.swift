//
//  AuthService.swift
//  MobileAndon
//
//  Created by Ricky Silitonga on 25/02/24.
//

import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift

class AuthService {
    static let shared = AuthService()
    
    @Published var userSession: FirebaseAuth.User?
    
    init() {
        self.userSession = Auth.auth().currentUser
        if let userSession = self.userSession {
            print("DEBUG: Current user session id: \(userSession.uid)")
        }
    }
    
    /// Auth service function to handle sign in
    /// - Parameters:
    ///   - email: email that used for login
    ///   - password: password that use for login
    @MainActor
    func signIn(with email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
        } catch {
            print("DEBUG: Failed to sign in the user with error: \(error.localizedDescription)")
        }
    }
    
    /// Auth service function to handle sign up
    /// - Parameters:
    ///   - email: email to register
    ///   - fullName: full name to register
    ///   - password: password to register
    @MainActor
    func signUp(with email: String, fullName: String, phoneNumber: String, password: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            let user = User(id: result.user.uid, email: email, fullName: fullName, phoneNumber: phoneNumber)
            self.userSession = result.user
            
            try await uploadUserData(user)
        } catch {
            print("DEBUG: Failed to create user with error: \(error.localizedDescription)")
        }
    }
    
    /// Function that handle sign out in firebase authentication
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("DEBUG: Unable to sign out with error: \(error.localizedDescription)")
            return
        }
        
        // set user session locally to nil
        self.userSession = nil
        
        // set the user in user service to nil
        UserService.shared.currentUser = nil
    }
    
    @MainActor
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
