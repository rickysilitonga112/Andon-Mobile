//
//  TicketDetailViewModel.swift
//  MobileAndon
//
//  Created by Ricky Silitonga on 03/03/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestoreSwift

class TicketDetailViewModel: ObservableObject {
    @Published var ticket: Ticket?
    
    @MainActor
    func fetchTicket(with uid: String) async throws {
        self.ticket = try await TicketService.fetchTicket(with: uid)
    }
    
    func updateResponse() async throws {
        guard let uid = Auth.auth().currentUser?.uid,
              let ticketId = ticket?.ticketId else {
            return
        }
        
        try await TicketService.updateData(ticketId: ticketId, [
//            "ticketStatus": ,
            "respondByUserId": uid
        ])
        
        try await self.fetchTicket(with: ticketId)
    }
    
    func closeTicket() {
        
    }
    
}
