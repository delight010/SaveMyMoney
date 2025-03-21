//
//  TopSpendingCategoryView.swift
//  AppUI
//
//  Created by abc on 3/21/25.
//  Copyright © 2025 delight010. All rights reserved.
//

import AppCore

import Charts
import SwiftUI

public struct TopSpendingCategoryView: View {
    private var chartData: [ChartData] = []
    
    public init(chartData: [ChartData]) {
        self.chartData = chartData
    }
    
    public var body: some View {
        HStack {
            ForEach(chartData.prefix(3), id: \.id) { data in
                GaugeView(current: data.value, label: data.label, color: data.color, systemImage: data.icon ?? "")
            }            
        } // HStack
    }
}

#Preview {
    let chartData = [
        ChartData(label: "Food", value: 44.17, color: .init(hex: "C1E1C1"), icon: "fork.knife"),
        ChartData(label: "Hobbies", value: 25, color: .init(hex: "C3B1E1"), icon: "gamecontroller.fill"),
        ChartData(label: "Transportation", value: 12.5, color: .init(hex: "A7C7E7"), icon: "car.fill"),
        ChartData(label: "Education", value: 0.08, color: .init(hex: "FFD8B1"), icon: "book.closed.fill")
    ]
    TopSpendingCategoryView(chartData: chartData)
}
