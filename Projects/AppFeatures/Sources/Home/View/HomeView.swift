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
    @ObservedObject private var consumptionViewModel: ConsumptionMainViewModel
    @ObservedObject private var planViewModel: PlanBuilderViewModel
    
    @CodableAppStorage(key: "currency", defaultValue: Currency.currencies[0]) private var currency
    
    public init(consumptionViewModel: ConsumptionMainViewModel, planViewModel: PlanBuilderViewModel) {
        self.consumptionViewModel = consumptionViewModel
        self.planViewModel = planViewModel
    }
    
    public var body: some View {
        VStack {
            if consumptionViewModel.isTodayInRange() {
                ConsumptionMainView(coordinator: ConsumptionCoordinator(router), viewModel: consumptionViewModel)
            } else {
                EmptyPlanView(coordinator: PlanBuildCoordinator(router))
            }
        } // VStack
        .onAppear {
            consumptionViewModel.fetchPlan()
        }
        .onReceive(consumptionViewModel.sendPlanResult, perform: { result in
            switch result {
            case .success:
                router.push(to: ConsumptionCoordinator.ConsumptionDestination.success)
            case .failure:
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    
                    router.push(to: ConsumptionCoordinator.ConsumptionDestination.failure)
                }
            default:
                break
            }
        })
    }
}

#Preview {
    @Previewable @StateObject var router = AppRouter()
    HomeView(consumptionViewModel: ConsumptionMainViewModel(), planViewModel: PlanBuilderViewModel())
        .environmentObject(router)
}
