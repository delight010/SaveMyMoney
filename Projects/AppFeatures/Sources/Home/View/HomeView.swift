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
                if let plan = consumptionViewModel.getPlan(), isProcessingPlan(plan: plan) {
                    ConsumptionMainView(coordinator: ConsumptionCoordinator(router))
                } else {
                    EmptyPlanView(coordinator: PlanBuildCoordinator(router))
                }
            } // VStack
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
                    EmptyView()
                }
            }
        } // NavigationStack
        .onAppear {
            consumptionViewModel.fetchPlan()
        }
    }
}

extension HomeView {
    
    func isProcessingPlan(plan: Plan) -> Bool {
        if Date.isCurrentDateInRange(from: plan.startDate, to: plan.endDate) {
            return true
        }
        
        if plan.status == .inProgress {
            return true
        }
        
        return false
    }
}

#Preview {
    @Previewable @StateObject var router = AppRouter()
    HomeView()
        .environmentObject(router)
}
