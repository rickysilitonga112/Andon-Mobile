//
//  HomeEmptyServerView.swift
//  MobileAndon
//
//  Created by Ricky Silitonga on 15/04/24.
//

import SwiftUI

struct EmptyServerView: View {
    let role: Role
    
    var body: some View {
        switch role {
        case .admin:
            Text("Should add a server")
        case .engineer,.none,.leader:
            Text("You don't have a server, ask admin to invite you to the server.")
        }
    }
}

#Preview {
    EmptyServerView(role: .admin)
}
