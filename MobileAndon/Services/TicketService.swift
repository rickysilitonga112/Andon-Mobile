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
        try await ticketCollection.getDocuments().documents.compactMap { entity in
            try? entity.data(as: Ticket.self)
        }
    }
    
    func fetchTicket(with ticketId: String) async throws -> Ticket? {
        try await ticketDocument(ticketId: ticketId).getDocument(as: Ticket.self)
    }
    
    func uploadTicket(_ ticket: Ticket) throws {
        try ticketDocument(ticketId: ticket.id)
            .setData(from: ticket, merge: false)
    }
    
    func updateData(ticketId: String, _ fields: [AnyHashable : Any]) async throws {
        try await ticketDocument(ticketId: ticketId).updateData(fields)
    }
    
    func getAllTicketCount() async throws -> Int {
        try await ticketCollection.aggregateCount()
    }
}
