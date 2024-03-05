//
//  ProfileViewModel.swift
//  MobileAndon
//
//  Created by Ricky Silitonga on 05/03/24.
//

import Foundation
import FirebaseAuth
import Combine

class ProfileViewModel: ObservableObject {
    @Published var currentUser: User?
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupSubscribers()
    }
    
    func signOut() {
        AuthService.shared.signOut()
    }
    
    private func setupSubscribers() {
        print("User service: \(String(describing: UserService.shared.currentUser?.email))")
        UserService.shared.$currentUser.sink { [weak self] user in
            self?.currentUser = user
            if let user = user  {
                print("DEBUG: Current user in Combine: \(user)")
            }
        }.store(in: &cancellables)
    }
    
}
