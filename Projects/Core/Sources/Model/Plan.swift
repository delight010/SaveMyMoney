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
public final class Plan {
    @Attribute(.unique) public var id: UUID
    public var startDate: Date
    public var endDate: Date
    public var currency: Currency
    public var budget: Decimal
    @Relationship(deleteRule: .cascade)
    public var consumption: [Expense]
    
    public init(startDate: Date, endDate: Date, currency: Currency, budget: Decimal, consumption: [Expense]) {
        self.id = .init()
        self.startDate = startDate
        self.endDate = endDate
        self.currency = currency
        self.budget = budget
        self.consumption = consumption
    }
}
