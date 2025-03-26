//
//  ChartDataProtocol.swift
//  AppCore
//
//  Created by abc on 3/21/25.
//  Copyright © 2025 delight010. All rights reserved.
//

import Foundation
import SwiftUI

public protocol ChartDataProtocol {
    func createChartData(plan: Plan) -> [ChartData]
    func createChartDataWithPercentage(plan: Plan) -> [ChartData]
}

public extension ChartDataProtocol {
    
    func createChartData(plan: Plan) -> [ChartData] {
        var result: [ChartData] = []
        let tags = plan.getTag()
        for tag in tags {
            let amount = plan.amountForTag(tag)
            let category = ExpenseCategory(rawValue: tag)
            result.append(
                ChartData(
                    label: category?.localizedName ?? "",
                    value: amount,
                    color: category?.color ?? .black,
                    icon: category?.icon
                )
            )
        }        
        return result
    }
    
    func createChartDataWithPercentage(plan: Plan) -> [ChartData] {
        var result: [ChartData] = []
        for tagData in plan.tagPercentage() {
            let category = ExpenseCategory(rawValue: tagData.tag)
            result.append(
                ChartData(
                    label: tagData.tag,
                    value: tagData.percentage,
                    color: category?.color ?? .black,
                    icon: category?.icon
                )
            )
        }
        return result
    }
}
