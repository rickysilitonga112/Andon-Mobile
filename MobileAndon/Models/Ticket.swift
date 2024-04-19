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

struct Ticket: Codable, Hashable {
    let id: String
    let machineType: String
    let machineName: String
    let problem: String
    var ticketStatus: String
    let createdBy: String
    let createdAt: Timestamp
    let closedAt: Timestamp?
    let respondBy: String?
    let actions: String?
    let closedBy: String?
    let serverId: String
    
    init(id: String,
        machineType: String,
         machineName: String,
         problem: String,
         ticketStatus: String,
         createdBy: String,
         createdAt: Timestamp,
         serverId: String,
         closedAt: Timestamp? = nil,
         respondBy: String? = nil,
         actions: String? = nil,
         closedBy: String? = nil
    ) {
        self.id = id
        self.machineType = machineType
        self.machineName = machineName
        self.problem = problem
        self.ticketStatus = ticketStatus
        self.createdBy = createdBy
        self.createdAt = createdAt
        self.serverId = serverId
        self.closedAt = closedAt
        self.respondBy = respondBy
        self.actions = actions
        self.closedBy = closedBy
    }
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case machineType = "machine_type"
        case machineName = "machine_name"
        case problem
        case ticketStatus = "ticket_status"
        case createdBy = "created_by"
        case createdAt = "created_at"
        case serverId = "server_id"
        case closedAt = "closed_at"
        case respondBy = "respond_by"
        case actions
        case closedBy = "closed_by"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.machineType = try container.decode(String.self, forKey: .machineType)
        self.machineName = try container.decode(String.self, forKey: .machineName)
        self.problem = try container.decode(String.self, forKey: .problem)
        self.ticketStatus = try container.decode(String.self, forKey: .ticketStatus)
        self.createdBy = try container.decode(String.self, forKey: .createdBy)
        self.createdAt = try container.decode(Timestamp.self, forKey: .createdAt)
        self.serverId = try container.decode(String.self, forKey: .serverId)
        self.closedAt = try container.decodeIfPresent(Timestamp.self, forKey: .closedAt)
        self.respondBy = try container.decodeIfPresent(String.self, forKey: .respondBy)
        self.actions = try container.decodeIfPresent(String.self, forKey: .actions)
        self.closedBy = try container.decodeIfPresent(String.self, forKey: .closedBy)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.machineType, forKey: .machineType)
        try container.encode(self.machineName, forKey: .machineName)
        try container.encode(self.problem, forKey: .problem)
        try container.encode(self.ticketStatus, forKey: .ticketStatus)
        try container.encode(self.createdBy, forKey: .createdBy)
        try container.encode(self.createdAt, forKey: .createdAt)
        try container.encode(self.serverId, forKey: .serverId)
        try container.encodeIfPresent(self.closedAt, forKey: .closedAt)
        try container.encodeIfPresent(self.respondBy, forKey: .respondBy)
        try container.encodeIfPresent(self.actions, forKey: .actions)
        try container.encodeIfPresent(self.closedBy, forKey: .closedBy)
    }
}

enum TicketStatus:String, Codable {
    case open = "Open"
    case ongoing = "Ongoing"
    case closed = "Closed"
    
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

enum MachineType: String, CaseIterable, Codable {
    case automation = "Automation"
    case tester = "Tester"
    case tooling = "Tooling"
    case other = "Other"
}
