//
//  TicketDetailView.swift
//  MobileAndon
//
//  Created by Ricky Silitonga on 28/02/24.
//

import SwiftUI
import FirebaseFirestore

struct TicketDetailView: View {
    let ticketId: String
    @StateObject private var viewModel = TicketDetailViewModel()
    
    var totalDowntime: Int {
        return 0
    }
    @State var text = ""
    @FocusState var isFocused: Bool
    @FocusState var isFocusedInToolbar: Bool
    
    @State private var showRespondAlert = false
    
    var ticket: Ticket? {
        return viewModel.ticket
    }
    
    var body: some View {
        ZStack {
            if let ticket = ticket {
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
                            if ticket.respondByUserId != nil {
                                
                            } else {
                                self.showRespondAlert.toggle()
                            }
                        } label: {
                            HStack {
                                Spacer()
                                Text(ticket.respondByUserId == nil ? "Respond Ticket": "Close Ticket")
                                    .foregroundStyle(ticket.ticketStatus.statusColor)
                                    .font(.headline)
                                Spacer()
                            }
                        }
                    }
                }
                .navigationTitle("Ticket Detail")
                .navigationBarTitleDisplayMode(.automatic)
                .alert("Are you sure to respond this ticket?", isPresented: $showRespondAlert) {
                    Button("Ok", role: .destructive)  {
                        Task {
                            try await viewModel.updateResponse()
                        }
                    }
                }
            } else {
                VStack {
                    Text("shold show loading indicator")
                }
            }
        }
        .onAppear {
            Task {
                try await viewModel.fetchTicket(with: ticketId)
            }
        }
    }
}

#Preview {
    TicketDetailView(ticketId: "FZt07Z3EJTS7ct9Mvots")
}

//#Preview {
//    TicketDetailView(ticket: Ticket(ticketId: "271817981273812738", machineType: .automation, machineName: "Bulb Press", problem: "Bulb press not stop running", ticketStatus: .ongoing, createdByUserId: "Tomas", createdAt: Timestamp(), closedAt: nil, respondByUserId: "Toto", actions: nil, closedBy: nil))
//}

//#Preview {
//    TicketDetailView(ticket: Ticket(ticketId: "271817981273812738", machineType: .automation, machineName: "Bulb Press", problem: "Bulb press cylinder not running", ticketStatus: .closed, createdByUserId: "Tomas", createdAt: Timestamp(), closedAt: Timestamp(), respondByUserId: "Toto", actions: "Change bulb cylinder", closedBy: "Toto"))
//}
//

