//
//  AddTicketViewModel.swift
//  MobileAndon
//
//  Created by Ricky Silitonga on 28/02/24.
//

import Firebase

@MainActor
class AddTicketViewModel: ObservableObject {
    @Published var machinetype: String = ""
    @Published var machineName: String = ""
    @Published var problem: String = ""
    
    
    func createTicket(user: User) -> Ticket {
        Ticket(id: NSUUID().uuidString,
               machineType: self.machinetype,
               machineName: self.machineName,
               problem: self.problem,
               ticketStatus: "Open",
               createdBy: user.id,
               createdAt: Timestamp(),
               serverId: user.serverId ?? "No Server"
        )
    }
    
    func uploadTicket(user: User) throws {
        let ticket = createTicket(user: user)
        try TicketService.shared.uploadTicket(ticket)
    }
}
