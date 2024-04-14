//
//  AMSecondaryButton.swift
//  MobileAndon
//
//  Created by Ricky Silitonga on 01/03/24.
//

import SwiftUI

struct AMSecondaryButton: View {
    let title: String
    var radius: CGFloat?
    let action: () -> Void
    
    var body: some View {
        
        Button(action: action) {
            Text(title)
                .font(.headline)
                .foregroundColor(.blue)
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: radius ?? 14)
                        .stroke(Color.blue.opacity(0.8), lineWidth: 1.5)
                )
        }
    }
}

#Preview {
    AMSecondaryButton(title: "Secondary Button", action: {})
}
