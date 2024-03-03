//
//  TicketDetailView.swift
//  MobileAndon
//
//  Created by Ricky Silitonga on 28/02/24.
//

import SwiftUI
import FirebaseFirestore

struct TicketDetailView: View {
    @StateObject private var vm = TicketDetailViewModel()
    let ticket: Ticket
    var totalDowntime: Int {
        return 0
    }
    
    @State private var showActionSheet = false
    
    var body: some View {
        List {
            Section {
                TicketDetailCell(title: "Project", value: ticket.machineName)
                TicketDetailCell(title: "Machine Type", value: ticket.machineType.title)
                TicketDetailCell(title: "Request By", value: ticket.createdByUserId)
                TicketDetailCell(title: "Created At", value: "14.20")
                if let closedAt = ticket.closedAt {
                    // TODO: - change to the actual time
                    TicketDetailCell(title: "Closed at", value: "14.00")
                }
            }
            Section("Status") {
                TicketDetailCell(title: "Status", value: ticket.ticketStatus.title, indicatorColor: ticket.ticketStatus.statusColor)
                if let closedBy = ticket.closedBy {
                    TicketDetailCell(title: "Done by", value: closedBy)
                } else {
                    if let respondByUserId = ticket.respondByUserId {
                        TicketDetailCell(title:"WIP by" , value: respondByUserId)
                    }
                }
                TicketDetailCell(title: "Total Downtime", value: "\(totalDowntime) Mins")
            }
            Section("Problem") {
                Text("\(ticket.problem)")
            }
            if let actions = ticket.actions {
                Section("Actions") {
                    Text("\(actions)")
                }
            }
            if ticket.closedBy == nil {
                Button {
                    // TODO: - handle actions
                } label: {
                    HStack {
                        Spacer()
                        Text(ticket.respondByUserId == nil ? "Respond Ticket": "Close Ticket")
                            .foregroundStyle(Color.red)
                            .font(.headline)
                        Spacer()
                    }
                }
            }
        }
        .navigationTitle("Ticket Detail")
        .navigationBarTitleDisplayMode(.automatic)
        // TODO: - create action sheet
    }
}

//#Preview {
//    TicketDetailView(ticket:  Ticket(machineType: .tester, machineName: "Red Led Tester", problem: "Pneumatic preasure is low", ticketStatus: .open, createdByUserId: "Ricky", createdAt: Timestamp()))
//}

//#Preview {
//    TicketDetailView(ticket: Ticket(ticketId: "271817981273812738", machineType: .automation, machineName: "Bulb Press", problem: "Bulb press not stop running", ticketStatus: .ongoing, createdByUserId: "Tomas", createdAt: Timestamp(), closedAt: nil, respondByUserId: "Toto", actions: nil, closedBy: nil))
//}

#Preview {
    TicketDetailView(ticket: Ticket(ticketId: "271817981273812738", machineType: .automation, machineName: "Bulb Press", problem: "Bulb press cylinder not running", ticketStatus: .closed, createdByUserId: "Tomas", createdAt: Timestamp(), closedAt: Timestamp(), respondByUserId: "Toto", actions: "Change bulb cylinder", closedBy: "Toto"))
}


