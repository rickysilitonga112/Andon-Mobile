//
//  TicketService.swift
//  MobileAndon
//
//  Created by Ricky Silitonga on 04/03/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct TicketService {
    
    static func fetchTickets() async throws -> [Ticket] {
        let snapshots = try await Firestore.firestore().collection("tickets").getDocuments()
        let tickets = snapshots.documents.compactMap { ticket in
            try? ticket.data(as: Ticket.self)
        }
        return tickets
    }
    
    static func fetchTicket(with ticketId: String) async throws -> Ticket? {
        do {
            return try await Firestore.firestore().collection("tickets").document(ticketId).getDocument(as: Ticket.self)
        } catch {
            print("Error to fetch ticket with error: \(error)")
            return nil
        }
        
    }
    
    static func uploadTicket(_ ticket: Ticket) {
        // encode the ticket
        guard let ticketData = try? Firestore.Encoder().encode(ticket) else { return }
        
        // create or get the collection of "ticket"
        // upload the document
        Firestore.firestore()
            .collection("tickets")
            .addDocument(data: ticketData) { error in
                // handle error
                if let error = error {
                    print("DEBUG: Error upload ticket with error: \(error.localizedDescription)")
                }
            }
    }
    
    static func updateData(ticketId: String, _ fields: [AnyHashable : Any]) async throws {
        try await Firestore.firestore().collection("tickets").document(ticketId).updateData(fields)
    }
}
