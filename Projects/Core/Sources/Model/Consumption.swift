//
//  Consumption.swift
//  Core
//
//  Created by abc on 3/9/25.
//  Copyright © 2025 delight010. All rights reserved.
//

import Foundation
import SwiftData

@Model
public final class Consumption {
    @Attribute(.unique) public var id: UUID
    public var date: Date
    public var amount: Decimal
    public var tag: String
    
    public init(date: Date, amount: Decimal, tag: String) {
        self.id = .init()
        self.date = date
        self.amount = amount
        self.tag = tag
    }
}
