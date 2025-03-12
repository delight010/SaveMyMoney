//
//  EmptyPlanView.swift
//  Features
//
//  Created by abc on 3/11/25.
//  Copyright © 2025 delight010. All rights reserved.
//

import UI

import SwiftUI

public struct EmptyPlanView: View {
    @EnvironmentObject var router: AppRouter
    
    var coordinator: PlanBuildCoordinator
    
    public init(coordinator: PlanBuildCoordinator) {
        self.coordinator = coordinator
    }
    
    public var body: some View {
        VStack {
            Text("There is no plan currently in progress.")
            Text("Would you like to start a new plan?")
            Button {
                router.push(to: PlanBuildCoordinator.PlanBuildDestination.dateRange)
            } label: {
                Text("Create Plan")
            }
            .buttonStyle(CapsuleButtonStyle())
        } // VStack
        .navigationDestination(for: PlanBuildCoordinator.PlanBuildDestination.self) { destination in
            switch destination {
            case .dateRange:
                PlanDateRangePickerView()
            case .currency:
                EmptyView()
            case .currencyAmount:
                PlanCurrencyAmountInputView()
            case .confirmation:
                PlanConfirmationView()
            }
        }
    }
}

#Preview {
    @Previewable @StateObject var router = AppRouter()
    EmptyPlanView(coordinator: PlanBuildCoordinator(router))
        .environmentObject(router)
}
