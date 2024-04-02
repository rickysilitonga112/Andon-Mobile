//
//  TicketService.swift
//  MobileAndon
//
//  Created by Ricky Silitonga on 04/03/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

@MainActor
struct TicketService {
    static let shared = TicketService()
    private let ticketCollection = Firestore.firestore().collection("tickets")
    
    // MARK: - Document Refference
    private func ticketDocument(ticketId: String) -> DocumentReference {
        ticketCollection.document(ticketId)
    }
    
    // MARK: Services
    func fetchTickets() async throws -> [Ticket] {
        try await ticketCollection.getDocuments().documents.compactMap { ticket in
            try? ticket.data(as: Ticket.self)
        }
    }
    
    func fetchTicket(with ticketId: String) async throws -> Ticket? {
        try await ticketDocument(ticketId: ticketId).getDocument(as: Ticket.self)
    }
    
    func saveData(_ ticket: Ticket) {
        // encode the ticket
        guard let ticketData = try? Firestore.Encoder().encode(ticket) else { return }
        
        // create or get the collection of "ticket"
        // upload the document
        ticketCollection.addDocument(data: ticketData) { error in
                // handle error
                if let error = error {
                    print("DEBUG: Error upload ticket with error: \(error.localizedDescription)")
                }
            }
    }
    
    func updateData(ticketId: String, _ fields: [AnyHashable : Any]) async throws {
        try await ticketDocument(ticketId: ticketId).updateData(fields)
    }
}
