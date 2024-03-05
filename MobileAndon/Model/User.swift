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
    var profileImageUrl: String?
    var role: Role = .none
}

enum Role: String, Codable {
    case admin = "Admin"
    case engineer = "Engineer"
    case none = "None"
    case leader = "Line Leader"
}
