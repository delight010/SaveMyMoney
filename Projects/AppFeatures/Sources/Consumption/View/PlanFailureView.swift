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
    @EnvironmentObject var router: AppRouter
    
    @ObservedObject private var viewModel: ConsumptionMainViewModel
    
    @State private var isPresented: Bool = false
    
    public init(viewModel: ConsumptionMainViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        VStack(spacing: 15) {
            Spacer()
            
            Image(systemName: "xmark.circle")
                .font(.system(size: 100))
                .mask {
                    LinearGradient(
                        gradient: Gradient(colors: [.clear, .red.opacity(0.7)]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                }
                .symbolEffect(.variableColor.cumulative, options: .repeat(3) ,isActive: isPresented)
            
            Text("😭Failure!")
                .bold()
            Text("You spent more than your budget!")
            
            Spacer()
            
            Button {
                viewModel.updatePlanStatus(.failure)
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
        }
    }
}

#Preview {
    @Previewable @StateObject var router = AppRouter()
    PlanFailureView(viewModel: ConsumptionMainViewModel())
        .environmentObject(router)
        .modelContainer(previewContainer)
}
