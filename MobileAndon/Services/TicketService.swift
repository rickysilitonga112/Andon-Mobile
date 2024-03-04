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
    
    static public func fetchTicket() async throws -> [Ticket] {
        let snapshots = try await Firestore.firestore().collection("tickets").getDocuments()
        let tickets = snapshots.documents.compactMap { ticket in
            try? ticket.data(as: Ticket.self)
        }
        return tickets
    }
    
    static public func uploadTicket(_ ticket: Ticket) {
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
    
}
