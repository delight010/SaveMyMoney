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
            
            Image(systemName: "trophy.circle")
                .font(.system(size: 100))
                .mask {
                    LinearGradient(
                        gradient: Gradient(colors: [.clear, .red.opacity(0.7)]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                }
                .symbolEffect(.variableColor.cumulative, options: .repeat(3) ,isActive: isPresented)
            
            Text("🎉Congratulations!")
                .bold()
            Text("Challenge successfully completed!")
            
            Spacer()
            
            Button {
                router.popToRoot()
            } label: {
                Text("OK")
            }
            .buttonStyle(BottomButtonStyle())
        } // VStack
        .padding(20)
        .background(Color.primary.colorInvert())
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
