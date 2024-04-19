//
//  UserService.swift
//  MobileAndon
//
//  Created by Ricky Silitonga on 27/02/24.
//

import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift

@MainActor
class UserService {
    static let shared = UserService()
    @Published var currentUser: User?
    private let userCollection = Firestore.firestore().collection("users")
    
    init() {
        Task {
            try await fetchCurrentUser()
        }
    }
    
    // MARK: - Document Reference
    private func userDocument(uid: String) -> DocumentReference {
        userCollection.document(uid)
    }
    
    // fetch the current user that have the session
    private func fetchCurrentUser() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { 
            throw FirebaseNetworkingError.failedUid
        }
        do {
            self.currentUser = try await fetchUser(uid: uid)
            print("DEBUG: Current user log in is: \(String(describing: currentUser))")
        } catch {
            print("DEBUG: Unable to fetch user with id:\(uid)")
            print("DEBUG: Unable to fetch with error: \(error)")
        }
    }
    
    
    /// Fetching user data on users collection
    /// - Parameter uid: uid string for the collection path
    /// - Returns: user data
    func fetchUser(uid: String) async throws -> User {
       try await userDocument(uid: uid).getDocument(as: User.self)
    }
    
    func fetchUser(uid: String) async throws -> String? {
        guard let userData = try await userDocument(uid: uid).getDocument().data() else {
            throw FirebaseNetworkingError.failedUid
        }
        return userData[User.CodingKeys.fullName.rawValue] as? String
    }
}
