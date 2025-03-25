//
//  AppearanceSettingView.swift
//  AppFeatures
//
//  Created by abc on 3/20/25.
//  Copyright © 2025 delight010. All rights reserved.
//

import AppUI
import AppCore

import SwiftUI

public struct AppearanceSettingView: View {
    @EnvironmentObject private var router: AppRouter
    @Environment(\.colorScheme) private var colorScheme
    @AppStorage("appColorScheme") private var appColorScheme: AppColorScheme = .system
    
    public init() {
        if appColorScheme == .system {
            appColorScheme = colorScheme == .light ? .light : .dark
        }
    }
    
    public var body: some View {
        VStack {
            List {
                Picker("color_scheme".localized(in: .module),
                       selection: $appColorScheme) {
                    ForEach(AppColorScheme.allCases.dropLast(), id: \.self) { scheme in
                        Text(scheme.rawValue.capitalized).tag(scheme)
                    }
                } // Picker
                .pickerStyle(.inline)
            } // List
            .listStyle(.inset)
            .tint(.primaryColor)
            
            Spacer()
        }// VStack
        .navigationBarBackButtonHidden()
        .toolbar {
            BackNavigationToolbarContent {
                router.pop()
            }
            ToolbarItem(placement: .navigation) {
                Text("appearance_setting".localized(in: .module))
            }
        } // Toolbar
    }
}

#Preview {
    @Previewable @StateObject var router = AppRouter()
    AppearanceSettingView()
        .environmentObject(router)
}
