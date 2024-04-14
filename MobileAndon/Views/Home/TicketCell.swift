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
                    Text(ticket.machineType)
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
                
                VStack(alignment: .trailing) {
                    Text("11.06")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                    Spacer()
                    HStack {
                        Circle()
                            .frame(width: 10, height: 10)
                            .foregroundStyle(getStatusColor(status: ticket.ticketStatus))
                        
                        Text(ticket.ticketStatus)
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
    
    private func getStatusColor(status: String) -> Color {
        switch status {
        case "On Progress": return .orange
        case "Closed": return .green
        default: return .red
        }
    }
}

#Preview {
    Color(uiColor: .systemGray6)
        .overlay {
            TicketCell(ticket: DeveloperPreview.shared.ticketOpen)
        }
        .ignoresSafeArea(.all)
}
