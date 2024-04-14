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
    
    
    func createTicket(uid: String) -> Ticket {
        Ticket(machineType: self.machinetype,
               machineName: self.machineName,
               problem: self.problem,
               ticketStatus: "Open",
               createdBy: uid,
               createdAt: Timestamp()
        )
    }
    
    func uploadTicket() throws {
        // get the user uid
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let ticket = createTicket(uid: uid)
        try TicketService.shared.uploadTicket(ticket)
    }
}
