//
//  User.swift
//  MobileAndon
//
//  Created by Ricky Silitonga on 26/02/24.
//

import Foundation

struct User: Identifiable, Codable, Hashable {
    let id: String
    let email: String
    let fullName: String
    let phoneNumber: String
    var profileImageUrl: String?
    var role: String?
    var serverId: String?
    
    init(id: String, 
         email: String,
         fullName: String,
         phoneNumber: String,
         role: String? = "None"
    ) {
        self.id = id
        self.email = email
        self.fullName = fullName
        self.phoneNumber = phoneNumber
        self.role = role
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case email
        case fullName = "full_name"
        case phoneNumber = "phone_number"
        case profileImageUrl = "profile_image_url"
        case role
        case serverId = "server_id"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.email = try container.decode(String.self, forKey: .email)
        self.fullName = try container.decode(String.self, forKey: .fullName)
        self.phoneNumber = try container.decode(String.self, forKey: .phoneNumber)
        self.profileImageUrl = try container.decodeIfPresent(String.self, forKey: .profileImageUrl)
        self.role = try container.decodeIfPresent(String.self, forKey: .role)
        self.serverId = try container.decodeIfPresent(String.self, forKey: .serverId)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.email, forKey: .email)
        try container.encode(self.fullName, forKey: .fullName)
        try container.encode(self.phoneNumber, forKey: .phoneNumber)
        try container.encodeIfPresent(self.profileImageUrl, forKey: .profileImageUrl)
        try container.encodeIfPresent(self.role, forKey: .role)
        try container.encodeIfPresent(self.serverId, forKey: .serverId)
    }
    
   
}

enum Role: String, Codable {
    case none = "None"
    case admin = "Admin"
    case engineer = "Engineer"
    case leader = "Line Leader"
}
