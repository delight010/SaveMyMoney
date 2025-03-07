//
//  Currency.swift
//  Core
//
//  Created by abc on 3/7/25.
//  Copyright © 2025 delight010. All rights reserved.
//

import Foundation

public struct Currency: Identifiable {
    public let id = UUID()
    public let flag: String
    public let country: String
    public let code: String
    public let unit: String
    public let decimals: Int
}

public extension Currency {
    static let currencies = [
        Currency(flag: "🇺🇸", country: "United States", code: "USD", unit: "Dollar", decimals: 2),
        Currency(flag: "🇪🇺", country: "European Union", code: "EUR", unit: "Euro", decimals: 2),
        Currency(flag: "🇯🇵", country: "Japan", code: "JPY", unit: "Yen", decimals: 0),
        Currency(flag: "🇬🇧", country: "United Kingdom", code: "GBP", unit: "Pound", decimals: 2),
        Currency(flag: "🇨🇦", country: "Canada", code: "CAD", unit: "Dollar", decimals: 2),
        Currency(flag: "🇦🇺", country: "Australia", code: "AUD", unit: "Dollar", decimals: 2),
        Currency(flag: "🇨🇭", country: "Switzerland", code: "CHF", unit: "Franc", decimals: 2),
        Currency(flag: "🇨🇳", country: "China", code: "CNY", unit: "Yuan", decimals: 2),
        Currency(flag: "🇰🇷", country: "South Korea", code: "KRW", unit: "Won", decimals: 0),
        Currency(flag: "🇮🇳", country: "India", code: "INR", unit: "Rupee", decimals: 2),
        Currency(flag: "🇧🇷", country: "Brazil", code: "BRL", unit: "Real", decimals: 2),
        Currency(flag: "🇷🇺", country: "Russia", code: "RUB", unit: "Ruble", decimals: 2),
        Currency(flag: "🇲🇽", country: "Mexico", code: "MXN", unit: "Peso", decimals: 2),
        Currency(flag: "🇸🇬", country: "Singapore", code: "SGD", unit: "Dollar", decimals: 2),
        Currency(flag: "🇹🇷", country: "Turkey", code: "TRY", unit: "Lira", decimals: 2),
        Currency(flag: "🇭🇰", country: "Hong Kong", code: "HKD", unit: "Dollar", decimals: 2),
        Currency(flag: "🇳🇴", country: "Norway", code: "NOK", unit: "Krone", decimals: 2),
        Currency(flag: "🇸🇪", country: "Sweden", code: "SEK", unit: "Krona", decimals: 2),
        Currency(flag: "🇳🇿", country: "New Zealand", code: "NZD", unit: "Dollar", decimals: 2),
        Currency(flag: "🇹🇭", country: "Thailand", code: "THB", unit: "Baht", decimals: 2)
    ]
}
