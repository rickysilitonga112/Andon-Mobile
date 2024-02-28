//
//  TicketModel.swift
//  MobileAndon
//
//  Created by Ricky Silitonga on 27/02/24.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestoreSwift

struct Ticket: Identifiable, Hashable, Codable {
    @DocumentID var ticketId: String?
    let machineType: MachineType
    let machineName: String
    let problem: String
    var ticketStatus: TicketStatus
    let createdBy: String
    let createdAt: Timestamp
    var closedAt: Timestamp?
    var respondBy: String?
    var actions: String?
    var closeBy: String?
    
    var id: String {
        return ticketId ?? NSUUID().uuidString
    }
}

enum TicketStatus: Codable {
    case open
    case ongoing
    case closed
    
    var title: String {
        switch self {
        case .open: "Open"
        case .ongoing: "Ongoing"
        case .closed: "Closed"
        }
    }
    
    var statusColor: Color {
        switch self {
        case .open:
            return .red
        case .ongoing:
            return .orange
        case .closed:
            return .green
        }
    }
}

enum MachineType: Codable {
    case automation, tester, tooling
    
    var title: String {
        switch self {
        case .automation:
            return "Automation"
        case .tester:
            return "End Tester"
        case .tooling:
            return "Production Tooling"
        }
    }
}
