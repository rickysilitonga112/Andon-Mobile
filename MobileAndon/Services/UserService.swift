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
            await fetchCurrentUser()
        }
    }
    
    // fetch the current user that have the session
    private func fetchCurrentUser() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        do {
            let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
            let user = try snapshot.data(as: User.self)
            self.currentUser = user
        } catch {
            print("DEBUG: Unable to fetch current user with error: \(error)")
        }
        print("DEBUG: Current user log in is: \(String(describing: currentUser))")
    }
    
    @MainActor
    static public func fetchFullName(with uid: String) async throws -> String? {
        guard let userData = try await Firestore.firestore().collection("users").document(uid).getDocument().data() else {
            return nil
        }
        return userData["fullName"] as? String
    }
    
    
}
