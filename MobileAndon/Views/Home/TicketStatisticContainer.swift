//
//  TicketStatisticContainer.swift
//  MobileAndon
//
//  Created by Ricky Silitonga on 27/02/24.
//

import SwiftUI

struct TicketStatisticContainer: View {
    let open: Int
    let ongoing: Int
    let closed: Int
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 14)
                .frame(height: 100)
            
            HStack() {
                Spacer()
                
                StatisticValueIndicator(title: "Open", value: open)
                
                Spacer()
                
                StatisticValueIndicator(title: "Ongoing", value: ongoing)
                
                Spacer()
                
                StatisticValueIndicator(title: "Closed", value: closed)
                
                Spacer()
            }
        }
    }
}

#Preview {
    TicketStatisticContainer(open: 3, ongoing: 1, closed: 100)
}

struct StatisticValueIndicator: View {
    let title: String
    let value: Int
    
    var body: some View {
        VStack(spacing: 8) {
            Text("\(value)")
                .foregroundColor(.white)
                .font(.title2)
                .fontWeight(.bold)
            
            Text(title)
                .foregroundColor(.white)
        }
    }
}
