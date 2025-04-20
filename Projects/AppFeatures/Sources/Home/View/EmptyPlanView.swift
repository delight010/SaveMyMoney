//
//  EmptyPlanView.swift
//  Features
//
//  Created by abc on 3/11/25.
//  Copyright © 2025 delight010. All rights reserved.
//

import AppUI
import AppCore

import SwiftUI

public struct EmptyPlanView: View {
    @EnvironmentObject private var router: AppRouter
    
    private var coordinator: PlanBuildCoordinator
    
    public init(coordinator: PlanBuildCoordinator) {
        self.coordinator = coordinator
    }
    
    public var body: some View {
        VStack {
            Text("empty_plan_info".localized(in: .module))
            Text("start_new_plan_prompt".localized(in: .module))
            Button {
                router.push(to: PlanBuildCoordinator.PlanBuildDestination.dateRange)
            } label: {
                Text("create_plan".localized(in: .module))
            }
            .buttonStyle(CapsuleButtonStyle())
        } // VStack
    }
}

#Preview {
    @Previewable @StateObject var router = AppRouter()
    EmptyPlanView(coordinator: PlanBuildCoordinator(router))
        .environmentObject(router)
}
