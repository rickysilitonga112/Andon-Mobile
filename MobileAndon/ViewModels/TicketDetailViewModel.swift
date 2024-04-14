//
//  TicketDetailViewModel.swift
//  MobileAndon
//
//  Created by Ricky Silitonga on 03/03/24.
//

import Foundation

@MainActor
class TicketDetailViewModel: ObservableObject {
    @Published var ticket: Ticket?
    
    func fetchTicket(with uid: String) async throws {
        self.ticket = try await TicketService.shared.fetchTicket(with: uid)
    }
    
    func setTicketData(_ ticket: Ticket) {
        self.ticket = ticket
    }
    
    func updateResponse() async throws {
        guard let uid = AuthService.shared.userSession?.uid,
              let ticketId = ticket?.id else {
            throw FirebaseNetworkingError.failedUid
        }
        
        try await TicketService.shared.updateData(ticketId: ticketId, [
            Ticket.CodingKeys.ticketStatus.rawValue: "On Progress",
            Ticket.CodingKeys.respondBy.rawValue: uid
        ])
        
        try await self.fetchTicket(with: ticketId)
    }
    
    // TODO: CLOSE TICKET 
    func closeTicket() {
        
    }
    
}
