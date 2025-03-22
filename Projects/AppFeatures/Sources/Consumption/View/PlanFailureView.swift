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
            
            ZStack {
                CircleAnimationView()
                Image(systemName: "flag.slash")
                    .font(.system(size: 130))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.red, .indigo],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .symbolEffect(.pulse, options: .repeat(1) ,isActive: isPresented)
            } // ZStack
            .frame(width: 250)
            
            Text("😭Failure!")
                .font(.title2)
                .bold()
            Text("You spent more than your budget!")
            
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
