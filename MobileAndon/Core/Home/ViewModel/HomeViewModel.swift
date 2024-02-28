//
//  HomeViewModel.swift
//  MobileAndon
//
//  Created by Ricky Silitonga on 27/02/24.
//

import Foundation
import FirebaseFirestore

class HomeViewModel: ObservableObject {
    
    @Published var tickets: [Ticket] = [
        Ticket(machineType: .tester, machineName: "Red Led Tester", problem: "Pneumatic preasure is low", ticketStatus: .open, createdBy: "Ricky", createdAt: Timestamp()),
        Ticket(machineType: .tester, machineName: "Red Led Tester", problem: "Pneumatic preasure is low", ticketStatus: .open, createdBy: "Ricky", createdAt: Timestamp())
    ]
    
}
