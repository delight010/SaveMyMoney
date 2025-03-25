//
//  PlanSuccessView.swift
//  AppFeatures
//
//  Created by abc on 3/19/25.
//  Copyright © 2025 delight010. All rights reserved.
//

import AppUI
import AppCore

import SwiftData
import SwiftUI

public struct PlanSuccessView: View {
    @EnvironmentObject private var router: AppRouter
    
    @ObservedObject private var viewModel: ConsumptionMainViewModel
    
    @State private var isPresented: Bool = false
    
    public init(viewModel: ConsumptionMainViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        VStack(spacing: 15) {
            Spacer()
            
            SuccessSymbolView()
                .frame(width: 250)
            
            Text("emoji-congratulation".localized(in: .module))
                .font(.title3)
                .bold()
            Text("plan_success_message".localized(in: .module))
            
            Spacer()
            
            Button {
                router.popToRoot()
            } label: {
                Text("button_ok".localized(in: .module))
            }
            .buttonStyle(BottomButtonStyle())
        } // VStack
        .padding(20)
        .background(.background)
        .clipShape(RoundedRectangle(cornerRadius: 10.0))
        .toolbar(.hidden)
        .onAppear {
            isPresented = true
            viewModel.updatePlanStatus(.success)
        }
    }
}

#Preview {
    @Previewable @StateObject var router = AppRouter()
    PlanSuccessView(viewModel: ConsumptionMainViewModel())
        .environmentObject(router)
        .modelContainer(previewContainer)
}
