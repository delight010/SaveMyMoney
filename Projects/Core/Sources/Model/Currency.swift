//
//  Currency.swift
//  Core
//
//  Created by abc on 3/7/25.
//  Copyright © 2025 delight010. All rights reserved.
//

import Foundation

public struct Currency: Identifiable, Hashable {
    public let id = UUID()
    public let localeIdentifier: String
    public let flag: String
    
    public private(set) var code: String
    public private(set) var country: String
    public private(set) var currencySymbol: String
    public private(set) var decimals: Int
    
    public let formatter: NumberFormatter
    
    public init(localeIdentifier: String, flag: String) {
        self.localeIdentifier = localeIdentifier
        self.flag = flag
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: localeIdentifier)
        formatter.usesGroupingSeparator = true
        formatter.groupingSize = 3
        self.formatter = formatter
        
        let locale = Locale(identifier: localeIdentifier)
        self.code = locale.currency?.identifier ?? "USD"
        
        if let regionCode = locale.region?.identifier {
            self.country = Locale.current.localizedString(forRegionCode: regionCode) ?? self.code
        } else {
            self.country = "United States"
        }
        
        formatter.currencyCode = self.code
        self.currencySymbol = formatter.currencySymbol
        self.decimals = formatter.maximumFractionDigits
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    public static func == (lhs: Currency, rhs: Currency) -> Bool {
        lhs.id == rhs.id
    }
}

public extension Currency {
    func formatStyle() -> Decimal.FormatStyle.Currency {
        return Decimal.FormatStyle.Currency
            .currency(code: code)
            .precision(.fractionLength(decimals))
            .locale(.init(identifier: localeIdentifier))
    }
}

public extension Currency {
    static let currencies = [
        Currency(localeIdentifier: "en_US", flag: "🇺🇸"),
        Currency(localeIdentifier: "en_150", flag: "🇪🇺"),
        Currency(localeIdentifier: "ja_JP", flag: "🇯🇵"),
        Currency(localeIdentifier: "en_GB", flag: "🇬🇧"),
        Currency(localeIdentifier: "en_CA", flag: "🇨🇦"),
        Currency(localeIdentifier: "en_AU", flag: "🇦🇺"),
        Currency(localeIdentifier: "de_CH", flag: "🇨🇭"),
        Currency(localeIdentifier: "zh_CN", flag: "🇨🇳"),
        Currency(localeIdentifier: "ko_KR", flag: "🇰🇷"),
        Currency(localeIdentifier: "hi_IN", flag: "🇮🇳"),
        Currency(localeIdentifier: "pt_BR", flag: "🇧🇷"),
        Currency(localeIdentifier: "ru_RU", flag: "🇷🇺"),
        Currency(localeIdentifier: "es_MX", flag: "🇲🇽"),
        Currency(localeIdentifier: "zh_SG", flag: "🇸🇬"),
        Currency(localeIdentifier: "tr_TR", flag: "🇹🇷"),
        Currency(localeIdentifier: "zh_HK", flag: "🇭🇰"),
        Currency(localeIdentifier: "no_NO", flag: "🇳🇴"),
        Currency(localeIdentifier: "sv_SE", flag: "🇸🇪"),
        Currency(localeIdentifier: "en_NZ", flag: "🇳🇿"),
        Currency(localeIdentifier: "th_TH", flag: "🇹🇭")
    ]
    
    static let currenciesDictionary: [String: Currency] = Dictionary(
        uniqueKeysWithValues: Currency.currencies.map { ($0.localeIdentifier, $0) }
    )
}
