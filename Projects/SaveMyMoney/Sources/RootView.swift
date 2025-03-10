//
//  RootView.swift
//  SaveMyMoney
//
//  Created by abc on 3/10/25.
//  Copyright © 2025 delight010. All rights reserved.
//

import UI

import SwiftUI

struct RootView: View {
    @State private var selectedMenu: AppDestination = .home
    
    public init() {}
    
    var body: some View {
        NavigationStack {
            TabView(selection: $selectedMenu) {
                Text("Home")
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }
                    .tag(AppDestination.home)
                
                Text("History")
                    .tabItem {
                        Label("History", systemImage: "gearshape.fill")
                    }
                    .tag(AppDestination.history)
                
                Text("Setting")
                    .tabItem {
                        Label("Setting", systemImage: "gearshape.fill")
                    }
                    .tag(AppDestination.setting)
            } // TabView
            .tint(Color.primaryColor)
        } // NavigationStack
    }
}

#Preview {
    RootView()
}
