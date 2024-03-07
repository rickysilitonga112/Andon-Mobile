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
                    
                    TicketStatisticContainer(open: 0, ongoing: 0, closed: 0)
                        .padding(.horizontal)
                        .padding(.top, 12)
                    
                    // active ticket section
                    Text("Active Tickets")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                        .padding(.top, 24)
                    
                    if !(viewModel.tickets.isEmpty) {
                        ScrollView {
                            LazyVStack(alignment: .leading, spacing: 12) {
                                ForEach(viewModel.tickets, id: \.self) { ticket in
                                    NavigationLink(value: ticket) {
                                        TicketCell(ticket: ticket)
                                    }
                                }
                            }
                        }
                        .scrollIndicators(.hidden)
                        .padding(.top, 12)
                        .padding(.horizontal)
                    } else {
                        // TODO: - Handle empty tickets
                        Text("Ticket is nil")
                    }
                   
                   Spacer()
                }
                .padding(.top)
                
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
            .onAppear {
                Task {
                    try await TicketService.fetchTickets()
                }
            }
            .navigationDestination(for: Ticket.self) { ticket in
                TicketDetailView(ticketId: ticket.id)
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
