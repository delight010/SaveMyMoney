//
//  ChartData.swift
//  Core
//
//  Created by abc on 3/13/25.
//  Copyright © 2025 delight010. All rights reserved.
//

import SwiftUI

public struct ChartData: Identifiable {
    public var id: UUID
    public let label: String
    public var value: Decimal
    public let color: Color
    public let icon: String?
    
    public init(label: String, value: Decimal, color: Color, icon: String? = nil) {
        self.id = .init()
        self.label = label
        self.value = value
        self.color = color
        self.icon = icon
    }
}

// MARK: Sample Data

#if DEBUG

extension ChartData: ChartDataProtocol {
    
    public static var sampleData: [ChartData] {
        struct TempChartDataProtocol: ChartDataProtocol {}
        return TempChartDataProtocol().createChartDataWithPercentage(plan: Plan.samplePlan)
    }
}

#endif
