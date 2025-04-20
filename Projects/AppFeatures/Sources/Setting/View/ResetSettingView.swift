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
                Text("reset_all_data_confirmation".localized(in: .module))
                Text("delete_all_data_warning".localized(in: .module))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            warningView()
            
            Spacer()
            
            Button("i_understand".localized(in: .module)) {
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
                Text("reset".localized(in: .module))
            }
        } // Toolbar
        .basicAlert(isPresented: $isShowingAlert,
                    title: "reset_alert_title".localized(in: .module),
                    message: "reset_alert_message".localized(in: .module),
                    primaryButtonTitle: "button_ok".localized(in: .module),
                    secondaryButtonTitle: "button_cancel".localized(in: .module)) {
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
                    Text("warning".localized(in: .module))
                        .font(.title3)
                        .bold()
                        .foregroundStyle(.red)
                } icon: {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .foregroundStyle(.yellow)
                }
                Divider()
                Text("reset_warning_message".localized(in: .module))
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
