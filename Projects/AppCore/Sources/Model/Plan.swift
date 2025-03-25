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
        
        public var localizedName: String {
            let key = "TaskStatus." + self.rawValue
            return String(localized: String.LocalizationValue(key), bundle: .module)
        }
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

// MARK: public functions

public extension Plan {
    
    func tagPercentage() -> [(tag: String, percentage: Decimal)] {
        let tags = getTag()
        var result: [(tag: String, percentage: Decimal)] = []
        for tag in tags {
            let amount = self.amountForTag(tag)
            let percentage = amount / budget * 100
            result.append((tag: tag, percentage: percentage))
        }
        return result.sorted { $0.percentage > $1.percentage }
    }
}

// MARK: internal functions

extension Plan {
    
    func getTag() -> Set<String> {
        return Set(consumption.map { $0.tag })
    }
    
    func amountForTag(_ tag: String) -> Decimal {
        return consumption
            .filter { $0.tag == tag }
            .reduce(0) { $0 + $1.amount }
    }
}

// MARK: Sample Data

#if DEBUG
public extension Plan {
    static var sampleConsumptions: [Consumption] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return [
            Consumption(
                title: "Pizza",
                date: dateFormatter.date(from: "2025-03-15")!,
                amount: 45000,
                tag: "Food"
            ),
            Consumption(
                title: "English Course",
                date: dateFormatter.date(from: "2025-03-15")!,
                amount: 100,
                tag: "Education"
            ),
            Consumption(
                title: "Subway",
                date: dateFormatter.date(from: "2025-03-16")!,
                amount: 15000,
                tag: "Transportation"
            ),
            Consumption(
                title: "Museum",
                date: dateFormatter.date(from: "2025-03-16")!,
                amount: 30000,
                tag: "Hobbies"
            ),
            Consumption(
                title: "Coffee",
                date: dateFormatter.date(from: "2025-03-17")!,
                amount: 8000,
                tag: "Food"
            )
        ]
    }
    
    static var samplePlan: Plan {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return Plan(
            startDate: dateFormatter.date(from: "2025-03-10")!,
            endDate: dateFormatter.date(from: "2025-03-18")!,
            budget: 120000,
            consumption: sampleConsumptions,
            status: .success,
            createdDate: dateFormatter.date(from: "2025-03-10")!
        )
    }
}
#endif
