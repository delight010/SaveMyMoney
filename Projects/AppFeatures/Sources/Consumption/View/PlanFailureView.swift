//
//  PlanFailureView.swift
//  AppFeatures
//
//  Created by abc on 3/18/25.
//  Copyright © 2025 delight010. All rights reserved.
//

import AppUI
import AppCore

import SwiftData
import SwiftUI

public struct PlanFailureView: View {
    @EnvironmentObject private var router: AppRouter
    
    @ObservedObject private var viewModel: ConsumptionMainViewModel
    
    @State private var isPresented: Bool = false
    
    public init(viewModel: ConsumptionMainViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        VStack(spacing: 15) {
            Spacer()
            
            FailureSymbolView()
                .frame(width: 250)
            
            Text("emoji-failure")
                .font(.title2)
                .bold()
            Text("plan_failure_message")
            
            Spacer()
            
            Button {
                router.popToRoot()
            } label: {
                Text("button_ok")
            }
            .buttonStyle(BottomButtonStyle())
        } // VStack
        .padding(20)
        .background(.background)
        .clipShape(RoundedRectangle(cornerRadius: 10.0))
        .toolbar(.hidden)
        .onAppear {
            isPresented = true
            viewModel.updatePlanStatus(.failure)
        }
    }
}

#Preview {
    @Previewable @StateObject var router = AppRouter()
    PlanFailureView(viewModel: ConsumptionMainViewModel())
        .environmentObject(router)
        .modelContainer(previewContainer)
}
