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
    
    private var user: User? {
        return UserService.shared.currentUser
    }
    
    var body: some View {
        Form {
//            Section("Select Machine Type") {
//                Picker("Machine Type", selection: $viewModel.machinetype) {
//                    ForEach(MachineType.allCases, id: \.self) {
//                        Text($0.title)
//                    }
//                }
//                .pickerStyle(.automatic)
//            }
            
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
                    // upload new ticket to firestore
                    do {
                        try viewModel.uploadTicket()
                        presentationMode.wrappedValue.dismiss()
                    } catch {
                        fatalError("DEBUG: Failed to uplaod ticket with error: \(error.localizedDescription)")
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
