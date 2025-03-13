//
//  ConsumptionMainView.swift
//  Features
//
//  Created by abc on 3/13/25.
//  Copyright © 2025 delight010. All rights reserved.
//

import Core
import UI

import Charts
import SwiftData
import SwiftUI

public struct ConsumptionMainView: View {
    @EnvironmentObject var router: AppRouter
    @Environment(\.modelContext) private var modelContext
    
    @CodableAppStorage(key: "currency", defaultValue: Currency.currencies[0]) private var currency
    
    @StateObject private var viewModel = ConsumptionMainViewModel()
    
    @Query(sort: \Plan.createdDate, order: .reverse) private var plans: [Plan]
    
    public var body: some View {
        VStack(spacing: 10) {
            dateInfoView()
            chartView()
            Spacer()
        } // VStack
        .onAppear {
            updateLatestPlan()
        }
    }
}

// MARK: Functions

extension ConsumptionMainView {
    
    func updateLatestPlan() {
        if let plan = plans.first {
            viewModel.setPlan(plan)
        }
    }
}

// MARK: UI Components

extension ConsumptionMainView {
    
    @ViewBuilder
    func dateInfoView() -> some View {
        HStack {
            let buttonWidth: CGFloat = 44
            
            ZStack {
                if !viewModel.isDateSameDayAsStartDate() {
                    Button("", systemImage: "chevron.left") {
                        viewModel.decreaseDate()
                    }
                    .buttonStyle(BasicButtonStyle())
                }
            } // ZStack
            .frame(width: buttonWidth)
            
            Text(viewModel.getDate())
                .bold()
            
            ZStack {
                if !viewModel.isDateSameDayAsToday() {
                    Button("", systemImage: "chevron.right") {
                        viewModel.increaseDate()
                    }
                    .buttonStyle(BasicButtonStyle())
                }
            } // ZStack
            .frame(width: buttonWidth)
        } // HStack
    }
    
    @ViewBuilder
    func chartView() -> some View {
        ZStack {
            Chart {
                ForEach(viewModel.chartData) { data in
                    SectorMark(
                        angle: .value("Consumption", data.value),
                        innerRadius: .ratio(0.6),
                        angularInset: 1.5
                    )
                    .foregroundStyle(data.color)
                }
            } // Chart
            .padding(20)
            VStack {
                Text("D-\(viewModel.getDday())")
                    .font(.largeTitle)
                    .bold()
                Text(currency.formatStyle().format(viewModel.getRemainBudget()))
                    .font(.title2)
            } // VStack
        } // ZStack
        .frame(width: 300, height: 300)
    }
}

@MainActor
let previewContainer: ModelContainer = {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: Plan.self, configurations: config)
        let context = container.mainContext
        
        let consumption: [Consumption] = [
            Consumption(date: Date(), amount: 100, tag: "food"),
            Consumption(date: Date(), amount: 200, tag: "food"),
            Consumption(date: Date(), amount: 300, tag: "food")
        ]
        let plan = Plan(
            startDate: Calendar.current.date(byAdding: .day, value: -2, to: .now)!,
            endDate: Calendar.current.date(byAdding: .day, value: 10, to: .now)!,
            budget: 30000,
            consumption: consumption
        )
        
        context.insert(plan)
        
        return container
    }
} ()

#Preview {
    @Previewable @StateObject var router = AppRouter()
    ConsumptionMainView()
        .environmentObject(router)
        .modelContainer(previewContainer)
}
