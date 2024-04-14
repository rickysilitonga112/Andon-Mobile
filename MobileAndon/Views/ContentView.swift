//
//  ContentView.swift
//  MobileAndon
//
//  Created by Ricky Silitonga on 25/02/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    
    var body: some View {
        Group {
            if viewModel.userSession == nil {
                LoginView()
            } else {
                MainTabbarView()
            }
        }
    }
}

#Preview {
    ContentView()
//        .environmentObject(ContentViewModel())
}
