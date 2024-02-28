//
//  TicketDetailView.swift
//  MobileAndon
//
//  Created by Ricky Silitonga on 28/02/24.
//

import SwiftUI
import FirebaseFirestore

struct TicketDetailView: View {
    let ticket: Ticket
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    TicketDetailView(ticket:  Ticket(machineType: .tester, machineName: "Red Led Tester", problem: "Pneumatic preasure is low", ticketStatus: .open, createdBy: "Ricky", createdAt: Timestamp()))
}
