//
//  TicketDetailCell.swift
//  MobileAndon
//
//  Created by Ricky Silitonga on 29/02/24.
//

import SwiftUI

struct TicketDetailCell: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack(spacing: 16) {
            Text(title)
                
            Spacer()
            
            HStack {
                
                // if indicator is not nil
//                if let indicatorColor = indicatorColor {
//                    Circle()
//                        .frame(width: 10, height: 10)
//                        .foregroundStyle(indicatorColor)
//                }
                
                Text(value)
                    .foregroundStyle(Color.gray)
                    .multilineTextAlignment(.trailing)
            }
        }
    }
}

#Preview {
    TicketDetailCell(title: "Status", value: "Open")
}
