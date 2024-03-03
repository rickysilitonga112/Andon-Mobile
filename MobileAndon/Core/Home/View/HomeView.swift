//
//  MainView.swift
//  MobileAndon
//
//  Created by Ricky Silitonga on 25/02/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    
    @State var presentAddNewTicket = false
    
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
                
                // floating action button
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button {
                            // add new ticket
                            self.presentAddNewTicket.toggle()
                            print("Add new ticket..")
                        } label: {
                            Image(systemName: "plus")
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .clipShape(Circle())
                                .padding()
                        }

                    }
                }
            }
            .navigationDestination(for: Ticket.self) { ticket in
                TicketDetailView(ticket: ticket)
            }
            .sheet(isPresented: $presentAddNewTicket) {
                NavigationStack {
                    AddTicketView(homeViewModel: viewModel)
                        .navigationTitle("Add new ticket")
                        .navigationBarTitleDisplayMode(.inline)
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
