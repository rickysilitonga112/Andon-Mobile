//
//  HomeViewModel.swift
//  MobileAndon
//
//  Created by Ricky Silitonga on 27/02/24.
//

import Foundation
import FirebaseFirestore
import Combine

@MainActor
class HomeViewModel: ObservableObject {
    @Published var tickets = [Ticket]()
    @Published var currentUser: User?
    
    private let db = Firestore.firestore()
    private var cancellables = Set<AnyCancellable>()
 
    init() {
        setupSubscribers()
        Task {
            try await fetchTickets()
        }
    }
    
    private func fetchTickets() async throws {
        db.collection("tickets").addSnapshotListener { (QuerySnapshot, error) in
            guard let documents = QuerySnapshot?.documents else {
                print("DEBUG: No Documents")
                return
            }
            
            let ticketList = documents.compactMap{ queryDocumentSnapshot in
                do {
                    let ticket = try queryDocumentSnapshot.data(as: Ticket.self)
                    return ticket
                } catch {
                    print("DEBUG: Error decoding ticket with error: \(error.localizedDescription)")
                    return nil
                }
            }
            // sort the ticket
//            tickets.sort { $0.createdAt > $1.createdAt }
            self.tickets = ticketList.sorted { $0.createdAt > $1.createdAt }
        }
    }
    
    private func setupSubscribers() {
        print("User service: \(String(describing: UserService.shared.currentUser?.email))")
        UserService.shared.$currentUser.sink { [weak self] user in
            self?.currentUser = user
            if let user = user {
                print("DEBUG: Current user in Combine: \(user)")
            }
        }.store(in: &cancellables)
    }
}
