//
//  PlanBarMarkView.swift
//  AppUI
//
//  Created by abc on 3/21/25.
//  Copyright © 2025 delight010. All rights reserved.
//

import AppCore

import Charts
import SwiftUI

public struct PlanBarMarkView: View {
    private var chartData: [ChartData] = []
    
    public init(chartData: [ChartData]) {
        self.chartData = chartData
    }
    
    public var body: some View {
        VStack {
            Chart(chartData) { data in
                BarMark(
                    x: .value("amount", data.value),
                    y: .value("consumtion", data.label),
                    width: .ratio(1.0)
                )
                .foregroundStyle(data.color)
            } // Chart
        } // VStack
    }
}

#Preview {
    PlanBarMarkView(
        chartData: ChartData.sampleData
            .sorted(by: { $0.value > $1.value }
                   )
    )
}
