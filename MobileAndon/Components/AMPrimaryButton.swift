//
//  AMPrimaryButton.swift
//  MobileAndon
//
//  Created by Ricky Silitonga on 26/02/24.
//

import SwiftUI

struct AMPrimaryButton: View {
    let title: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.clear)
                .frame(height: 57)
                .background {
                    color
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                }
            
            Text(title)
                .font(.title3)
                .foregroundColor(.white)
        }
        .frame(width: UIScreen.main.bounds.width * 0.8)
        .onTapGesture(perform: action)
    }
}

#Preview {
    AMPrimaryButton(title: "Continue", color: .blue, action: {})
}
