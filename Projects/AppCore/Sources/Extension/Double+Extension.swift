//
//  Double+Extension.swift
//  AppCore
//
//  Created by abc on 3/19/25.
//  Copyright © 2025 delight010. All rights reserved.
//

import Foundation

public extension Double {
    
    init(_ decimal: Decimal) {
        self = NSDecimalNumber(decimal: decimal).doubleValue
    }
}
