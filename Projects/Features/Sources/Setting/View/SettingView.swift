//
//  SettingView.swift
//  Features
//
//  Created by abc on 3/11/25.
//  Copyright © 2025 delight010. All rights reserved.
//

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
            .navigationTitle("Setting")
            .navigationBarTitleDisplayMode(.inline)
        } // NavigationStack
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 20)
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

extension SettingView {
    
    @ViewBuilder
    func settingList() -> some View {
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
    }
}

#Preview {
    @Previewable @StateObject var router = AppRouter()
    SettingView(coordinator: SettingCoordinator(router))
        .environmentObject(router)
}
