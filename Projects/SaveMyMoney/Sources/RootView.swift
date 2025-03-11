//
//  RootView.swift
//  SaveMyMoney
//
//  Created by abc on 3/10/25.
//  Copyright © 2025 delight010. All rights reserved.
//

import Features
import UI

import SwiftUI
import SwiftData

struct RootView: View {
    @EnvironmentObject var router: AppRouter
    var coordinator: RootCoordinator
    @State private var selectedMenu: AppDestination = .home
    
    public init(coordinator: RootCoordinator) {
        self.coordinator = coordinator
    }
    
    var body: some View {
        NavigationStack(path: $router.path) {
            TabView(selection: $selectedMenu) {
                HomeView()
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }
                    .tag(AppDestination.home)
                    .navigationTitle("")
                
                Text("History")
                    .tabItem {
                        Label("History", systemImage: "magazine.fill")
                    }
                    .tag(AppDestination.history)
                
                SettingView(coordinator: SettingCoordinator(router))
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
    @Previewable @StateObject var router = AppRouter()
    RootView(coordinator: RootCoordinator(router))
        .environmentObject(router)
}
