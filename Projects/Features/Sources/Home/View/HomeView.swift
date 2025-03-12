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
    @Query(sort: \Plan.createdDate, order: .reverse) private var plans: [Plan]
    var latestPlan: Plan? {
        return plans.first
    }
    
    public init() {}
    
    public var body: some View {
        NavigationStack(path: $router.path) {
            VStack {
                if isProcessingPlan() {
                    Text("Progressing")
                } else {
                    EmptyPlanView(coordinator: PlanBuildCoordinator(router))
                }
            } // VStack
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
