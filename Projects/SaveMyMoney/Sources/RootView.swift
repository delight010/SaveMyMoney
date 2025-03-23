//
//  RootView.swift
//  SaveMyMoney
//
//  Created by abc on 3/10/25.
//  Copyright © 2025 delight010. All rights reserved.
//

import AppFeatures
import AppUI
import AppCore

import SwiftUI
import SwiftData

struct RootView: View {
    @EnvironmentObject private var router: AppRouter
    @StateObject private var consumptionViewModel = ConsumptionMainViewModel()
    @StateObject private var planViewModel = PlanBuilderViewModel()
    
    @State private var selectedMenu: AppDestination = .home
    private var coordinator: RootCoordinator
    
    public init(coordinator: RootCoordinator) {
        self.coordinator = coordinator
    }
    
    var body: some View {
        NavigationStack(path: $router.path) {
            TabView(selection: $selectedMenu) {
                HomeView(consumptionViewModel: consumptionViewModel, planViewModel: planViewModel)
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }
                    .tag(AppDestination.home)
                    .navigationTitle("")
                
                HistoryView()
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
            .toolbar(.hidden)
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: PlanBuildCoordinator.PlanBuildDestination.self) { destination in
                switch destination {
                case .dateRange:
                    PlanDateRangePickerView(viewModel: planViewModel)
                case .currency:
                    EmptyView()
                case .currencyAmount:
                    PlanCurrencyAmountInputView(viewModel: planViewModel)
                case .confirmation:
                    PlanConfirmationView(viewModel: planViewModel)
                }
            }
            .navigationDestination(for: ConsumptionCoordinator.ConsumptionDestination.self) { destination in
                switch destination {
                case .add:
                    AddConsumptionView(viewModel: consumptionViewModel)
                case .edit(consumptionID: let id):
                    EditConsumptionView(viewModel: consumptionViewModel, consumptionID: id)
                case .success:
                    PlanSuccessView(viewModel: consumptionViewModel)
                case .failure:
                    PlanFailureView(viewModel: consumptionViewModel)
                }
            }
            .navigationDestination(for: SettingCoordinator.SettingDestination.self) { destination in
                switch destination {
                case .language:
                    EmptyView()
                case .appearance:
                    AppearanceSettingView()
                case .reset:
                    ResetSettingView()
                case .resetSuccess:
                    ResetSuccessView()
                }
            } // navigationDestination
        } // NavigationStack
    }
}

#Preview {
    @Previewable @StateObject var router = AppRouter()
    RootView(coordinator: RootCoordinator(router))
        .environmentObject(router)
}
