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
    let createdByUserId: String
    let createdAt: Timestamp
    var closedAt: Timestamp?
    var respondByUserId: String?
    var actions: String?
    var closedBy: String?
    
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

enum MachineType: CaseIterable, Codable {
    case automation, tester, tooling, other
    
    var title: String {
        switch self {
        case .automation:
            return "Automation"
        case .tester:
            return "End Tester"
        case .tooling:
            return "Production Tooling"
        case .other:
            return "Other"
        }
    }
}
