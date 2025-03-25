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
    
    public var localizedName: String {
        let key = "ExpenseCategory." + self.rawValue
        return String(localized: String.LocalizationValue(key), bundle: .module)
    }
    
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
            return .init(hex: "87C55F")
        case .transportation:
            return .init(hex: "FE88B1")
        case .hobbies:
            return .init(hex: "F89C74")
        case .fashionBeauty:
            return .init(hex: "9EB9F3")
        case .housingCommunication:
            return .init(hex: "66C5CC")
        case .education:
            return .init(hex: "8BE0A4")
        case .health:
            return .init(hex: "F6CF71")
        case .dailyNecessities:
            return .init(hex: "C9DB74")
        case .otherExpenses:
            return .init(hex: "B3B3B3")
        }
    }
}
