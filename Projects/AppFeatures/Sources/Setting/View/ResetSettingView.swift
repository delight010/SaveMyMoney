//
//  ResetSettingView.swift
//  AppFeatures
//
//  Created by abc on 3/23/25.
//  Copyright © 2025 delight010. All rights reserved.
//

import AppUI
import AppCore

import SwiftData
import SwiftUI

public struct ResetSettingView: View {
    @EnvironmentObject private var router: AppRouter
    
    @CodableAppStorage(key: "currency", defaultValue: Currency.currencies[0]) private var currency
    
    @StateObject private var viewModel = ResetSettingViewModel()
    
    @State private var isShowingAlert: Bool = false
    
    public init() { }
    
    public var body: some View {
        VStack(spacing: 15) {
            Group {
                Text("reset_all_data_confirmation")
                Text("delete_all_data_warning")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            warningView()
            
            Spacer()
            
            Button("I understand") {
                isShowingAlert.toggle()
            }
            .buttonStyle(BottomButtonStyle())
        } // VStack
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 20)
        .navigationBarBackButtonHidden()
        .toolbar {
            BackNavigationToolbarContent {
                router.pop()
            }
            ToolbarItem(placement: .navigation) {
                Text("reset")
            }
        } // Toolbar
        .basicAlert(isPresented: $isShowingAlert,
                    title: "Reset All Data",
                    message: "Are you sure you want to reset all data?",
                    primaryButtonTitle: "OK",
                    secondaryButtonTitle: "Cancel") {
            viewModel.deleteAllData()
            resetCurrency()
            router.push(to: SettingCoordinator.SettingDestination.resetSuccess)
        } secondaryButtonAction: { }
    }
}

// MARK: Functions

extension ResetSettingView {
    
    func resetCurrency() {
        currency = Currency.currencies[0]
    }
}

// MARK: UI Components

extension ResetSettingView {
    
    func warningView() -> some View {
        VStack {
            Group {
                Label {
                    Text("warning")
                        .font(.title3)
                        .bold()
                        .foregroundStyle(.red)
                } icon: {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .foregroundStyle(.yellow)
                }
                Divider()
                Text("reset_warning_message")
            } // Group
            .frame(maxWidth: .infinity, alignment: .leading)
        } // VStack
        .padding()
        .backgroundRoundedRectangle()
    }
}

#Preview {
    ResetSettingView()
}
