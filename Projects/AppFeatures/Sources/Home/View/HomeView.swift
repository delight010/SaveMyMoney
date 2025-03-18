//
//  HomeView.swift
//  Features
//
//  Created by abc on 3/11/25.
//  Copyright © 2025 delight010. All rights reserved.
//

import AppUI
import AppCore

import SwiftData
import SwiftUI

public struct HomeView: View {
    @EnvironmentObject var router: AppRouter
    @StateObject private var consumptionViewModel = ConsumptionMainViewModel()
    @StateObject private var planViewModel = PlanBuilderViewModel()
    
    @CodableAppStorage(key: "currency", defaultValue: Currency.currencies[0]) private var currency
    
    public init() {}
    
    public var body: some View {
        NavigationStack(path: $router.path) {
            VStack {
                if consumptionViewModel.isTodayInRange() {
                    ConsumptionMainView(coordinator: ConsumptionCoordinator(router), viewModel: consumptionViewModel)
                } else {
                    EmptyPlanView(coordinator: PlanBuildCoordinator(router))
                }
            } // VStack
            .onReceive(consumptionViewModel.sendPlanResult, perform: { result in
                switch result {
                case .success:
                    router.push(to: ConsumptionCoordinator.ConsumptionDestination.success)
                case .failure:
                    router.push(to: ConsumptionCoordinator.ConsumptionDestination.failure)
                default:
                    break
                }
            })
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
                    EmptyView()
                case .failure:
                    PlanFailureView(viewModel: consumptionViewModel)
                }
            }
        } // NavigationStack
        .onAppear {
            consumptionViewModel.fetchPlan()
        }
    }
}

#Preview {
    @Previewable @StateObject var router = AppRouter()
    HomeView()
        .environmentObject(router)
}
