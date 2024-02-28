//
//  TicketCard.swift
//  MobileAndon
//
//  Created by Ricky Silitonga on 27/02/24.
//

import SwiftUI
import Firebase

struct TicketCell: View {
    let ticket: Ticket
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 14)
                .fill(.white)

            HStack(spacing: 12) {
                VStack(alignment: .leading) {
                    Text(ticket.machineType.title)
                        .font(.footnote)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Text(ticket.problem)
                        .font(.subheadline)
                        .multilineTextAlignment(.leading)
                    
                    Spacer()
                    
                    Text(ticket.machineName)
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                VStack {
                    Text("11.06")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                    Spacer()
                    HStack {
                        Circle()
                            .frame(width: 10, height: 10)
                            .foregroundStyle(ticket.ticketStatus.statusColor)
                        
                        Text(ticket.ticketStatus.title)
                            .font(.footnote)
                            .foregroundColor(.secondary)
                            
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .padding(12)
        }
        .frame(height: 100)

    }
}

#Preview {
    Color(uiColor: .systemGray6)
        .overlay {
            TicketCell(ticket: Ticket(machineType: .tester, machineName: "Red Led Tester", problem: "Pneumatic preasure is low", ticketStatus: .open, createdBy: "Ricky", createdAt: Timestamp()))
        }
        .ignoresSafeArea(.all)
}
