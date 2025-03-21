//
//  ConsumptionMainView.swift
//  Features
//
//  Created by abc on 3/13/25.
//  Copyright © 2025 delight010. All rights reserved.
//

import AppCore
import AppUI

import Charts
import SwiftData
import SwiftUI

public struct ConsumptionMainView: View {
    @EnvironmentObject private var router: AppRouter
    
    @CodableAppStorage(key: "currency", defaultValue: Currency.currencies[0]) private var currency
    
    @ObservedObject private var viewModel: ConsumptionMainViewModel
    
    var coordinator: ConsumptionCoordinator
    
    public init(coordinator: ConsumptionCoordinator, viewModel: ConsumptionMainViewModel) {
        self.coordinator = coordinator
        self.viewModel = viewModel
    }
    
    public var body: some View {
        VStack(spacing: 10) {
            dateInfoView()
            chartView()
            if let plan = viewModel.getPlan(), !plan.consumption.isEmpty {
                Group {
                    Text("Top Spending Category")
                        .bold()
                    HStack {
                        TopSpendingCategoryView(chartData: viewModel.createChartDataWithPercentage(plan: plan))
                    } // HStack
                } // Group
            }
            consumptionListView()
        } // VStack
        .onAppear {
            if !viewModel.isTodayInRange() {
                router.push(to: ConsumptionCoordinator.ConsumptionDestination.success)
            }
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
        .frame(height: 44)
        .frame(maxWidth: .infinity)
        .overlay(alignment: .trailing) {
            HStack {
                Spacer()
                Button("", systemImage: "plus") {
                    router.push(to: ConsumptionCoordinator.ConsumptionDestination.add)
                }
                .buttonStyle(BasicButtonStyle())
            } // HStack
            .frame(height: 44)
            .frame(maxWidth: .infinity)
        }
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
    
    @ViewBuilder
    func consumptionListView() -> some View {
        List {
            Section("Consumption Record") {
                if viewModel.consumption.isEmpty {
                    Text("There is no consumption record.")
                } else {
                    ForEach(viewModel.consumption, id: \.self) { data in
                        NavigationLink(value: ConsumptionCoordinator.ConsumptionDestination.edit(consumptionID: data.id)) {
                            HStack {
                                Text("[\(data.tag)]")
                                Text(data.title)
                                Spacer()
                                Text(currency.formatStyle().format(data.amount))
                            } // HStack
                        }
                    }
                    .onDelete { indexSet in
                        viewModel.deleteConsumption(at: indexSet)
                    }
                }
            } // Section
        } // List
        .listStyle(.inset)
    }
}

@MainActor
let previewContainer: ModelContainer = {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: false)
        let container = try! ModelContainer(for: Plan.self, configurations: config)
        let context = container.mainContext
        
        let consumption: [Consumption] = [
            Consumption(title: "Banana", date: Date(), amount: 100, tag: "food"),
            Consumption(title: "Drink", date: Date(), amount: 200, tag: "food"),
            Consumption(title: "Snack", date: Date(), amount: 300, tag: "food")
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
    ConsumptionMainView(coordinator: ConsumptionCoordinator(router), viewModel: ConsumptionMainViewModel())
        .environmentObject(router)
        .modelContainer(previewContainer)
}
