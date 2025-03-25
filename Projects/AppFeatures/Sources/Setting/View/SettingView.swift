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
    @EnvironmentObject private var router: AppRouter
    
    var coordinator: SettingCoordinator
    
    public init(coordinator: SettingCoordinator) {
        self.coordinator = coordinator
    }
    
    public var body: some View {
        VStack {
            settingList()
            Spacer()
        } // VStack
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity)
    }
}

extension SettingView {
    
    func settingList() -> some View {
        VStack {
            Group {
                ForEach(SettingCoordinator.SettingDestination.allCases.dropLast()) { destination in
                    Button {
                        router.push(to: destination)
                    } label: {
                        Label(destination.title, systemImage: destination.icon)
                    }
                    Divider()
                } // ForEach
            } // Group
            .frame(maxWidth: .infinity, alignment: .leading)
            .tint(.primary)
        } // VStack        
    }
}

#Preview {
    @Previewable @StateObject var router = AppRouter()
    SettingView(coordinator: SettingCoordinator(router))
        .environmentObject(router)
}
