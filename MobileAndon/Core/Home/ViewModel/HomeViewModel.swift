//
//  HomeViewModel.swift
//  MobileAndon
//
//  Created by Ricky Silitonga on 27/02/24.
//

import Foundation
import FirebaseFirestore

class HomeViewModel: ObservableObject {
    
    @Published private(set) var tickets = [Ticket]()
 
    init() {
        self.addTicketMockData()
    }
    
    private func addTicketMockData() {
        let mockData: [Ticket] = [
            Ticket(machineType: .tester, machineName: "Red Led Tester", problem: "Pneumatic preasure is low", ticketStatus: .open, createdByUserId: "Ricky", createdAt: Timestamp()),
            Ticket(machineType: .tester, machineName: "Red Led Tester", problem: "Pneumatic preasure is low", ticketStatus: .open, createdByUserId: "Ricky", createdAt: Timestamp()),
            Ticket(ticketId: "271817981273812738", machineType: .automation, machineName: "Bulb Press", problem: "Bulb press not stop running", ticketStatus: .ongoing, createdByUserId: "Tomas", createdAt: Timestamp(), closedAt: nil, respondByUserId: "Toto", actions: nil, closedBy: nil)
        ]
        tickets += mockData
    }
    
    public func addNewTickets(_ newTicket: Ticket) {
        tickets.append(newTicket)
    }
}
