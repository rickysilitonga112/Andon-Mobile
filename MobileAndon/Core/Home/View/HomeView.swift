//
//  MainView.swift
//  MobileAndon
//
//  Created by Ricky Silitonga on 25/02/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(uiColor: UIColor.secondarySystemBackground)
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    Text("Daily Tickets Statistics")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                    
                    TicketStatisticContainer(open: 2, ongoing: 3, closed: 100)
                        .padding(.horizontal)
                        .padding(.top, 12)
                    
                    // active ticket section
                    Text("Active Tickets")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                        .padding(.top, 24)
                        // active tickets
                    
                    ScrollView {
                        LazyVStack(alignment: .leading, spacing: 12) {
                            ForEach(viewModel.tickets, id: \.self) { ticket in
                                NavigationLink(value: ticket) {
                                    TicketCell(ticket: ticket)
                                }
                            }
                        }
                        
                    }
                    .padding(.top, 12)
                    .padding(.horizontal)
                   
                   Spacer()
                }
                .padding(.vertical)
            }
            .navigationDestination(for: Ticket.self) { ticket in
                TicketDetailView(ticket: ticket)
            }
        }
    }
}

#Preview {
    HomeView()
}
