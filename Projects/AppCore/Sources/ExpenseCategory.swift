//
//  ExpenseCategory.swift
//  Core
//
//  Created by abc on 3/14/25.
//  Copyright © 2025 delight010. All rights reserved.
//

import SwiftUI

public enum ExpenseCategory: String, CaseIterable, Identifiable {
    case food = "Food"
    case transportation = "Transportation"
    case hobbies = "Hobbies"
    case fashionBeauty = "Fashion/Beauty"
    case housingCommunication = "Housing/Communication"
    case education = "Education"
    case health = "Health"
    case dailyNecessities = "Daily Necessities"
    case otherExpenses = "Other Expenses"
    
    public var id: String { self.rawValue }
    
    public var icon: String {
        switch self {
        case .food:
            return "fork.knife"
        case .transportation:
            return "car.fill"
        case .hobbies:
            return "gamecontroller.fill"
        case .fashionBeauty:
            return "bag.fill"
        case .housingCommunication:
            return "house.fill"
        case .education:
            return "book.closed.fill"
        case .health:
            return "heart.text.square"
        case .dailyNecessities:
            return "basket.fill"
        case .otherExpenses:
            return "ellipsis.circle.fill"
        }
    }
    
    public var color: Color {
        switch self {
        case .food:
            return .init(hex: "C1E1C1")
        case .transportation:
            return .init(hex: "A7C7E7")
        case .hobbies:
            return .init(hex: "C3B1E1")
        case .fashionBeauty:
            return .init(hex: "FFCFD2")
        case .housingCommunication:
            return .init(hex: "D2B48C")
        case .education:
            return .init(hex: "FFD8B1")
        case .health:
            return .init(hex: "FFB3B3")
        case .dailyNecessities:
            return .init(hex: "B4EBE0")
        case .otherExpenses:
            return .init(hex: "BDFFD6")
        }
    }
}
