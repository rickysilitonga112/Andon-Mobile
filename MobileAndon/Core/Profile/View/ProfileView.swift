//
//  ProfileView.swift
//  MobileAndon
//
//  Created by Ricky Silitonga on 25/02/24.
//

import SwiftUI
import Kingfisher

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    
    var body: some View {
        NavigationStack {
            
            VStack {
                HStack {
                    Spacer()
                    AMCircularProfileImage(user: viewModel.currentUser)
                    Spacer()
                }
                .padding(.vertical)
                
                List {
                    Section {
                        HStack {
                            Text("Email")
                            Spacer()
                            Text(viewModel.currentUser?.email ?? "email.value")
                        }
                        
                        HStack {
                            Text("Full Name")
                            Spacer()
                            Text(viewModel.currentUser?.fullName ?? "fullName.value")
                        }
                        
                        HStack {
                            Text("Phone Number")
                            Spacer()
                            Text("08xxx")
                        }
                        
                        HStack {
                            Text("Role")
                            Spacer()
                            Text(viewModel.currentUser?.role.rawValue ?? "role.value")
                        }
                    }
                    
                    Section {
                        Button {
                            viewModel.signOut()
                        } label: {
                            
                            HStack {
                                Spacer()
                                Text("Logout")
                                Spacer()
                            }
                        }
                    }
                }
            }
//            .listStyle(.inset)
        }
    }
}

#Preview {
    ProfileView()
}



