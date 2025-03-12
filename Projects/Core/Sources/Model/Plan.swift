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
    public enum TaskStatus: String, Codable {
        case success = "Success"
        case failure = "Failure"
        case inProgress = "InProgress"
    }
    
    @Attribute(.unique) public var id: UUID
    public var startDate: Date
    public var endDate: Date
    public var budget: Decimal
    @Relationship(deleteRule: .cascade)
    public var consumption: [Consumption]
    public var status: TaskStatus
    public var createdDate: Date
    
    public init(startDate: Date, endDate: Date, budget: Decimal, consumption: [Consumption], status: TaskStatus = .inProgress, createdDate: Date = Date()) {
        self.id = .init()
        self.startDate = startDate
        self.endDate = endDate
        self.budget = budget
        self.consumption = consumption
        self.status = status
        self.createdDate = createdDate
    }
}
