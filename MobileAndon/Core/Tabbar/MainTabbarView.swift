//
//  MainTabbarView.swift
//  MobileAndon
//
//  Created by Ricky Silitonga on 25/02/24.
//

import SwiftUI

struct MainTabbarView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .navigationTitle("Profile")
                .tabItem {
                    Label("Home", systemImage: selectedTab == 0 ? "house.fill" : "house")
//                    Image(systemName: selectedTab == 0 ? "house.fill" : "house")
//                        .environment(\.symbolVariants, selectedTab == 0 ? .fill : .none)
                }
                .tag(0)
                .onAppear {
                    selectedTab = 0
                }
            
            TicketHistory()
                .tabItem {
                    Label("History", systemImage: selectedTab == 0 ? "list.clipboard.fill" : "list.clipboard")
                }
                .tag(1)
                .onAppear {
                    selectedTab = 1
                }
            
            ChatView()
                .tabItem {
                    Label("Chat", systemImage: selectedTab == 2 ? "message.badge.fill" : "message.badge")
                }
                .tag(2)
                .onAppear {
                    selectedTab = 2
                }
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: selectedTab == 3 ? "person.fill" : "person")
                }
                .tag(3)
                .onAppear {
                    selectedTab = 3
                }
        }
    }
}

#Preview {
    MainTabbarView()
}
