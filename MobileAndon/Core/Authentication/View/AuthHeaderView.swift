//
//  AuthHeaderView.swift
//  MobileAndon
//
//  Created by Ricky Silitonga on 26/02/24.
//

import SwiftUI

struct AuthHeaderView: View {
    let imageSize: CGFloat = 100
    var body: some View {
        VStack {
            Image("icon")
                .resizable()
                .frame(width: imageSize, height: imageSize)
            
            Text("Andon Mobile")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top, 6)
        }
    }
}

#Preview {
    AuthHeaderView()
}
