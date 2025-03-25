//
//  PlanSectorMarkView.swift
//  AppUI
//
//  Created by abc on 3/21/25.
//  Copyright © 2025 delight010. All rights reserved.
//

import AppCore

import Charts
import Foundation
import SwiftData
import SwiftUI

public struct PlanSectorMarkView: View {
    private var planStatus: String = ""
    private var chartData: [ChartData] = []
    
    public init(planStatus: String, chartData: [ChartData]) {
        self.planStatus = planStatus
        self.chartData = chartData
    }
    
    public var body: some View {
        ZStack {
            Chart {
                ForEach(chartData) { data in
                    SectorMark(
                        angle: .value("Consumption", data.value),
                               innerRadius: .ratio(0.6),
                               angularInset: 1.5
                    )
                    .foregroundStyle(data.color)
                }
            } // Chart
            
            Text(planStatus)
                .font(.title)
                .bold()
        } // ZStack
    }
}

#Preview {
    PlanSectorMarkView(planStatus: Plan.samplePlan.status.localizedName, chartData: ChartData.sampleData)
}
