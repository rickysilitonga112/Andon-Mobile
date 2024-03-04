//
//  AddTicketView.swift
//  MobileAndon
//
//  Created by Ricky Silitonga on 28/02/24.
//

import SwiftUI

struct AddTicketView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var homeViewModel: HomeViewModel
    @StateObject var viewModel = AddTicketViewModel()
    
//    @DocumentID var ticketId: String?
//    let machineType: MachineType
//    let machineName: String
//    let problem: String
//    var ticketStatus: TicketStatus
//    let createdByUserId: String
//    let createdAt: Timestamp
//    var closedAt: Timestamp?
//    var respondByUserId: String?
//    var actions: String?
//    var closedBy: String?
//    
//    var id: String {
//        return ticketId ?? NSUUID().uuidString
//    }
    
    // should take from user
    // 1. machine type
    // 2. machine name
    // 3. problem
    // 4.
    
    private var user: User? {
        return UserService.shared.currentUser
    }
    
    var body: some View {
        Form {
            Section("Select Machine Type") {
                Picker("Machine Type", selection: $viewModel.machinetype) {
                    ForEach(MachineType.allCases, id: \.self) {
                        Text($0.title)
                    }
                }
                .pickerStyle(.automatic)
            }
            
            Section("Machine Name") {
                TextField("Input machine name", text: $viewModel.machineName)
                    .autocorrectionDisabled()
            }
            
            Section("Machine Problem") {
                TextField("Input machine problem", text: $viewModel.problem, axis: .vertical)
                    .autocorrectionDisabled()
            }
        }
        .toolbar {
            // if pressed dismiss the view
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Cancel")
                        .font(.subheadline)
                }
            }
            
            // if pressed, add the new ticket the database
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    Task {
//                        try await viewModel.uploadThread(caption: caption)
                        presentationMode.wrappedValue.dismiss()
                    }
                } label: {
                    Text("Add")
                        .font(.subheadline)
                        .fontWeight(.semibold)
//                        .opacity(caption.isEmpty ? 0.5 : 1)
                }
            }
        }
    }
}

#Preview {
    AddTicketView(homeViewModel: HomeViewModel())
}
