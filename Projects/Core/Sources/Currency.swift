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
    
    public private(set) lazy var code: String = {
        let locale = Locale(identifier: localeIdentifier)
        return locale.currency?.identifier ?? "USD"
    }()
    
    public private(set) lazy var country: String = {
        let locale = Locale(identifier: localeIdentifier)
        guard let regionCode = locale.region?.identifier else { return "United States" }
        return Locale.current.localizedString(forRegionCode: regionCode) ?? code
    }()
    
    public private(set) lazy var unit: String = {
        formatter.currencyCode = self.code
        return formatter.currencySymbol
    }()
    
    public private(set) lazy var decimals: Int = {
        formatter.currencyCode = self.code
        return formatter.maximumFractionDigits
    }()
    
    private let formatter: NumberFormatter
    
    public init(localeIdentifier: String, flag: String) {
        self.localeIdentifier = localeIdentifier
        self.flag = flag
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale(identifier: localeIdentifier)
        formatter.usesGroupingSeparator = true
        formatter.groupingSize = 3
        self.formatter = formatter
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    public static func == (lhs: Currency, rhs: Currency) -> Bool {
        lhs.id == rhs.id
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
