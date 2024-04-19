//
//  Server.swift
//  MobileAndon
//
//  Created by Ricky Silitonga on 15/04/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct AMServer: Codable {
    let id: String
    let serverName: String
    let adminId: String
    let createdAt: Timestamp
    var lastUpdatedAt: Timestamp
    var members: [String] = []
    var tickets: [String] = []
    var totalTickets = 0
    
    init(id: String, 
         serverName: String,
         adminId: String,
         createdAt: Timestamp,
         lastUpdatedAt: Timestamp
    ) {
        self.id = id
        self.serverName = serverName
        self.adminId = adminId
        self.createdAt = createdAt
        self.lastUpdatedAt = lastUpdatedAt
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case serverName = "server_name"
        case adminId = "admin_id"
        case createdAt = "created_at"
        case lastUpdatedAt = "last_updated_at"
        case members
        case tickets
        case totalTickets = "total_tickets"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.serverName = try container.decode(String.self, forKey: .serverName)
        self.adminId = try container.decode(String.self, forKey: .adminId)
        self.createdAt = try container.decode(Timestamp.self, forKey: .createdAt)
        self.lastUpdatedAt = try container.decode(Timestamp.self, forKey: .lastUpdatedAt)
        self.members = try container.decode([String].self, forKey: .members)
        self.tickets = try container.decode([String].self, forKey: .tickets)
        self.totalTickets = try container.decode(Int.self, forKey: .totalTickets)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.serverName, forKey: .serverName)
        try container.encode(self.adminId, forKey: .adminId)
        try container.encode(self.createdAt, forKey: .createdAt)
        try container.encode(self.lastUpdatedAt, forKey: .lastUpdatedAt)
        try container.encode(self.members, forKey: .members)
        try container.encode(self.tickets, forKey: .tickets)
        try container.encode(self.totalTickets, forKey: .totalTickets)
    }
}
