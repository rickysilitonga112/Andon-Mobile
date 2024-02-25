//
//  ContentViewModel.swift
//  MobileAndon
//
//  Created by Ricky Silitonga on 25/02/24.
//

import Firebase
import FirebaseAuth
import Combine

class ContentViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupSubsribers()
    }
    
    private func setupSubsribers() {
        AuthService.shared.$userSession.sink { [weak self] userSession in
            self?.userSession = userSession
        }.store(in: &cancellables)
    }
}
