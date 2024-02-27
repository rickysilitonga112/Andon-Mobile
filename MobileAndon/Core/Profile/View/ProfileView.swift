//
//  ProfileView.swift
//  MobileAndon
//
//  Created by Ricky Silitonga on 25/02/24.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        Button("Sign Out") {
            Task {
                await AuthService.shared.signOut()
            }
        }
    }
}

#Preview {
    ProfileView()
}
