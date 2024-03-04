//
//  AddTicketViewModel.swift
//  MobileAndon
//
//  Created by Ricky Silitonga on 28/02/24.
//

import Firebase

class AddTicketViewModel: ObservableObject {
    @Published var machinetype: MachineType = .other
    @Published var machineName: String = ""
    @Published var problem: String = ""
    
    
    func createNewTicket(user: User) -> Ticket {
        
        return Ticket(machineType: self.machinetype,
                      machineName: self.machineName,
                      problem: self.problem,
                      ticketStatus: .open,
                      createdByUserId: user.id,
                      createdAt: Timestamp()
        )
    }
    
    func uploadTicket() {
        // get the user uid
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let ticket = Ticket(
            machineType: self.machinetype,
            machineName: self.machineName,
            problem: self.problem,
            ticketStatus: .open,
            createdByUserId: uid,
            createdAt: Timestamp()
        )
        
        TicketService.uploadTicket(ticket)
    }
}
