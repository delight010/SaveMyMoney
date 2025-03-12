//
//  HomeView.swift
//  Features
//
//  Created by abc on 3/11/25.
//  Copyright © 2025 delight010. All rights reserved.
//

import UI
import Core

import SwiftData
import SwiftUI

public struct HomeView: View {
    @EnvironmentObject var router: AppRouter
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel = PlanBuilderViewModel()
    
    @CodableAppStorage(key: "currency", defaultValue: Currency.currencies[0]) private var currency
    
    @Query(sort: \Plan.createdDate, order: .reverse) private var plans: [Plan]
    
    var latestPlan: Plan? {
        return plans.first
    }
    
    public init() {}
    
    public var body: some View {
        NavigationStack(path: $router.path) {
            VStack {
                if isProcessingPlan() {
                    if let lastestPlan = latestPlan {
                        Text("\(lastestPlan.budget)")
                        Text("\(currency.flag) \(currency.code)")
                    }
                } else {
                    EmptyPlanView(coordinator: PlanBuildCoordinator(router))
                }
            } // VStack
            .navigationDestination(for: PlanBuildCoordinator.PlanBuildDestination.self) { destination in
                switch destination {
                case .dateRange:
                    PlanDateRangePickerView(viewModel: viewModel)
                case .currency:
                    EmptyView()
                case .currencyAmount:
                    PlanCurrencyAmountInputView(viewModel: viewModel)
                case .confirmation:
                    PlanConfirmationView(viewModel: viewModel)
                }
            }
        } // NavigationStack
    }
}

extension HomeView {
    
    func isProcessingPlan() -> Bool {
        guard let plan = latestPlan else {
            return false
        }
        
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
