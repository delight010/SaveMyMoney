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
                
            } label: {
                Text("Create Plan")
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
