//
//  HistoryView.swift
//  AppFeatures
//
//  Created by abc on 3/21/25.
//  Copyright © 2025 delight010. All rights reserved.
//

import AppCore
import AppUI

import Charts
import Foundation
import SwiftData
import SwiftUI

public struct HistoryView: View {
    @CodableAppStorage(key: "currency", defaultValue: Currency.currencies[0]) private var currency
    
    @StateObject private var viewModel = HistoryViewModel()
    
    @State private var isShowDetail: Bool = false
    @State private var selectedPlan: Plan?
    
    public init() {}
    
    public var body: some View {
        VStack {
            if viewModel.plan.isEmpty {
                emptyView()
            } else {
                titleView()
                listView()
            }
        } // VStack
        .sheet(item: $selectedPlan, content: { plan in
            HistoryDetailView(viewModel: viewModel, plan: plan)
        })
        .onAppear {
            viewModel.fetchPlan()
        }
    }
}

// MARK: UI Components

extension HistoryView {

    func emptyView() -> some View {
        VStack {
            Image("pigSymbol", bundle: .init(identifier: "delight010.savemymoney.appui"))
                .resizable()
                .scaledToFit()
                .frame(width: 70, height: 70)
            Text("no_data_yet")
        } // VStack
    }
    
    func titleView() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .foregroundStyle(LinearGradient(colors: [Color.primaryColor.opacity(0.5), Color.pressedButtonBackground], startPoint: .topLeading, endPoint: .bottomTrailing))
            Label("Your Challenge History", systemImage: "trophy.fill")
                .font(.title2)
                .bold()
                .foregroundStyle(.background)
        } // ZStack
        .frame(height: 80)
        .padding(.horizontal, 20)
    }
    
    func listView() -> some View {
        List(viewModel.plan) { plan in
            HStack {
                PlanSectorMarkView(planStatus: plan.status.rawValue, chartData: viewModel.createChartData(plan: plan))
                    .padding(5)
                VStack {
                    Group {
                        HStack {
                            Text("start_date")
                            Spacer()
                            Text(DateFormatter().yearAndDay.string(from: plan.startDate))
                        } // HStack
                        HStack {
                            Text("end_date")
                            Spacer()
                            Text(DateFormatter().yearAndDay.string(from: plan.endDate))
                        } // HStack
                        HStack {
                            Text("budget")
                            Spacer()
                            Text(currency.formatStyle().format(plan.budget))
                        } // HStack
                    } // Group
                    .lineLimit(1)
                    .font(.subheadline)
                    
                    Button {
                        isShowDetail.toggle()
                        selectedPlan = plan
                    } label: {
                        Text("show_detail")
                    }
                    .font(.subheadline)
                    .buttonStyle(CapsuleButtonStyle())
                } // VStack
            } // HStack
            .padding(5)
            .listRowSeparator(.hidden)
            .backgroundRoundedRectangle()
        }
        .listStyle(.inset)
    }
}

#Preview {
    HistoryView()
}
