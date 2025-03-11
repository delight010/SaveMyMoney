//
//  Date+Extension.swift
//  Core
//
//  Created by abc on 3/11/25.
//  Copyright © 2025 delight010. All rights reserved.
//

import Foundation

extension Date {
    
    static func isCurrentDateInRange(from startDate: Date, to endDate: Date) -> Bool {
        let currentDate = Date()
        return currentDate >= startDate && currentDate <= endDate
    }
}
