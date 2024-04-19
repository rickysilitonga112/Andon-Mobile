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
    
    private let machineType = ["Automation", "Tester", "Tooling"]
    
    var body: some View {
        Form {
            Section("Select Machine Type") {
                Picker("Machine Type", selection: $viewModel.machinetype) {
                    ForEach(self.machineType, id: \.self) {type in
                        Text("\(type)")
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
//            if pressed dismiss the view
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Cancel")
                        .font(.subheadline)
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    guard let user = user else { return }
                    do {
                        try viewModel.uploadTicket(user: user)
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
