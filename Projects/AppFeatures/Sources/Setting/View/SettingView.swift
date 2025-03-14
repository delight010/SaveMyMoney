//
//  SettingView.swift
//  Features
//
//  Created by abc on 3/11/25.
//  Copyright © 2025 delight010. All rights reserved.
//

import AppCore

import SwiftUI

public struct SettingView: View {
    @EnvironmentObject var router: AppRouter
    var coordinator: SettingCoordinator
    
    public init(coordinator: SettingCoordinator) {
        self.coordinator = coordinator
    }
    
    public var body: some View {
        NavigationStack(path: $router.path) {
            VStack {
                settingList()
                Spacer()
            } // VStack
            .padding(.horizontal, 20)
        } // NavigationStack
        .frame(maxWidth: .infinity)
    }
}

extension SettingView {
    
    @ViewBuilder
    func settingList() -> some View {
        LazyVStack {
            Group {
                ForEach(SettingCoordinator.SettingDestination.allCases) { destination in
                    Button {
                        router.push(to: destination)
                    } label: {
                        Label("\(destination.id)".capitalized, systemImage: destination.icon)
                    }
                    Divider()
                } // ForEach
            } // Group
            .frame(maxWidth: .infinity, alignment: .leading)
            .tint(.primary)
        } // LazyVStack
        .navigationDestination(for: SettingCoordinator.SettingDestination.self) { destination in
            switch destination {
            case .language:
                EmptyView()
            case .currency:
                EmptyView()
            case .appearance:
                EmptyView()
            case .reset:
                EmptyView()
            }
        } // navigationDestination
    }
}

#Preview {
    @Previewable @StateObject var router = AppRouter()
    SettingView(coordinator: SettingCoordinator(router))
        .environmentObject(router)
}
