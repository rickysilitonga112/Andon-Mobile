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
        
    }
}
