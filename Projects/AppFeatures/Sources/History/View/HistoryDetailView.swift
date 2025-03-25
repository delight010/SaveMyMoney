//
//  HistoryDetailView.swift
//  AppFeatures
//
//  Created by abc on 3/23/25.
//  Copyright © 2025 delight010. All rights reserved.
//

import AppUI
import AppCore

import SwiftUI

struct HistoryDetailView: View {
    @CodableAppStorage(key: "currency", defaultValue: Currency.currencies[0]) private var currency
    
    @ObservedObject private var viewModel: HistoryViewModel
    
    @State private var plan: Plan
    @State private var chartData: [ChartData]
    @State private var chartHeight: CGFloat
    
    init(viewModel: HistoryViewModel, plan: Plan) {
        self.viewModel = viewModel
        self.plan = plan
        let _chartdata = viewModel.createChartData(plan: plan).sorted(by: { $0.value > $1.value })
        self.chartData = _chartdata
        self.chartHeight = CGFloat(_chartdata.count * 85)
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                topSymbolView()
                inputPlanView()
                VStack(spacing: 15) {
                    Text("top_spending_category".localized(in: .module))
                        .bold()
                    Divider()
                    TopSpendingCategoryView(chartData: viewModel.createChartDataWithPercentage(plan: plan))
                }
                .padding(15)
                .backgroundRoundedRectangle()
                
                VStack(spacing: 15) {
                    Text("spending_by_category".localized(in: .module))
                        .bold()
                    Divider()
                    PlanBarMarkView(chartData: chartData)
                        .frame(height: chartHeight)
                }
                .padding(15)
                .backgroundRoundedRectangle()
            }
        } // ScrollView
        .padding(20)
        .scrollClipDisabled()
    }
}

extension HistoryDetailView {
    
    func topSymbolView() -> some View {
        Group {
            if plan.status == .success {
                SuccessSymbolView()
                    .frame(width: 230)
                Text("emoji-history-detail-success".localized(in: .module))
            } else {
                FailureSymbolView()
                    .frame(width: 230)
                Text("emoji-history-detail-fail".localized(in: .module))
            }
        } // Group        
        .font(.title2)
        .bold()
    }
    
    func inputPlanView() -> some View {
        VStack {
            HStack {
                Text("start_date".localized(in: .module))
                Spacer()
                Text(DateFormatter().yearAndDay.string(from: plan.startDate))
            }
            Divider()
            HStack {
                Text("end_date".localized(in: .module))
                Spacer()
                Text(DateFormatter().yearAndDay.string(from: plan.endDate))
            }
            Divider()
            HStack {
                Text("budget".localized(in: .module))
                Spacer()
                Text(currency.formatStyle().format(plan.budget))
            }
        } // VStack
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 8)
                .foregroundStyle(Color.secondaryColor.opacity(0.3))
        }
    }
}

#Preview {
    HistoryDetailView(
        viewModel: HistoryViewModel(),
        plan: Plan.samplePlan
    )
}
