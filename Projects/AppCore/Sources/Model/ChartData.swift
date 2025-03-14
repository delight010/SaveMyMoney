//
//  ChartData.swift
//  Core
//
//  Created by abc on 3/13/25.
//  Copyright © 2025 delight010. All rights reserved.
//

import SwiftUI

public struct ChartData: Identifiable {
    public var id: UUID
    public let label: String
    public var value: Decimal
    public let color: Color
    
    public init(label: String, value: Decimal, color: Color) {
        self.id = .init()
        self.label = label
        self.value = value
        self.color = color
    }
}
