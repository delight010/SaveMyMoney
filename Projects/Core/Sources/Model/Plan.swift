//
//  Plan.swift
//  Core
//
//  Created by abc on 3/9/25.
//  Copyright © 2025 delight010. All rights reserved.
//

import Foundation
import SwiftData

@Model
final class Plan {
    @Attribute(.unique) var id: UUID
    var startDate: Date
    var endDate: Date
    var budget: Decimal
    @Relationship(deleteRule: .cascade)
    var consumption: [Expense]
    
    init(startDate: Date, endDate: Date, budget: Decimal, consumption: [Expense]) {
        self.id = .init()
        self.startDate = startDate
        self.endDate = endDate
        self.budget = budget
        self.consumption = consumption
    }
}
