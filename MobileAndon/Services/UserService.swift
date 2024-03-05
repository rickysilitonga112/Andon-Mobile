//
//  UserService.swift
//  MobileAndon
//
//  Created by Ricky Silitonga on 27/02/24.
//

import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift


class UserService {
    static let shared = UserService()
    
    @Published var currentUser: User?
    
    init() {
        Task {
            try await fetchCurrentUser()
        }
    }
    
    // fetch the current user that have the session
    @MainActor
    private func fetchCurrentUser() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
        let user = try snapshot.data(as: User.self)
        self.currentUser = user
        
        print("DEBUG: Current user log in is: \(currentUser!)")
    }
    
    @MainActor
    static public func fetchFullName(with uid: String) async throws -> String? {
        guard let userData = try await Firestore.firestore().collection("users").document(uid).getDocument().data() else {
            return nil
        }
        return userData["fullName"] as? String
    }
    
    
}
