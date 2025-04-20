//
//  DataFormatter+Extension.swift
//  Core
//
//  Created by abc on 3/7/25.
//  Copyright © 2025 delight010. All rights reserved.
//

import Foundation

public extension DateFormatter {
    var yearAndDay: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.locale = Locale.current
        return formatter
    }
}
